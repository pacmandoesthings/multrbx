#include "common.h"

TEX_DECLARE2D(Texture0, 0);
TEX_DECLARE2D(Texture1, 1);
TEX_DECLARE2D(Texture2, 2);
TEX_DECLARE2D(Texture3, 3);

// .xy = gbuffer width/height, .zw = inverse gbuffer width/height
uniform float4 TextureSize;
uniform float4 Params1;
uniform float4 Params2;
uniform float4 Params3;
uniform float4 Params4;
uniform float4 bloomParams; // .x - strength (0 disables), .y - threshold
 
#if defined(GLSL) || defined(DX11)
float4 convertPosition(float4 p, float scale)
{
	return p;
}    
#else
float4 convertPosition(float4 p, float scale)
{
	// half-pixel offset
	return p + float4(-TextureSize.z, TextureSize.w, 0, 0) * scale;
}
#endif

#ifndef GLSL
float2 convertUv(float4 p)
{
	return p.xy * float2(0.5, -0.5) + 0.5;
}
#else
float2 convertUv(float4 p)
{
	return p.xy * 0.5 + 0.5;
}
#endif


// simple pass through structure
struct VertexOutput
{
    float4 p    : POSITION;
    float2 uv   : TEXCOORD0;
};

// simple pass through structure
struct VertexOutput_Pos
{
    float4 p    : POSITION;
    float2 uv   : TEXCOORD0;
    float4 pos  : TEXCOORD1;
};

// position and tex coord + 4 additional tex coords
struct VertexOutput_4uv
{
    float4 p    : POSITION;
    float2 uv   : TEXCOORD0;
	float4 uv12 : TEXCOORD1;
	float4 uv34 : TEXCOORD2;
};

// position and tex coord + 8 additional tex coords
struct VertexOutput_8uv
{
    float4 p    : POSITION;
    float2 uv   : TEXCOORD0;
	float4 uv12 : TEXCOORD1;
	float4 uv34 : TEXCOORD2;
	float4 uv56 : TEXCOORD3;
	float4 uv78 : TEXCOORD4;
};

VertexOutput passThrough_vs(float4 p: POSITION)
{
    VertexOutput OUT;
    OUT.p = convertPosition(p, 1);
    OUT.uv = convertUv(p);

    return OUT;
}

VertexOutput_Pos passThroughPos_vs(float4 p: POSITION)
{
    VertexOutput_Pos OUT;
    OUT.p = convertPosition(p, 1);
    OUT.uv = convertUv(p);
    OUT.pos = OUT.p;

    return OUT;
}

float4 passThrough_ps( VertexOutput IN ) : COLOR0
{
	return tex2D(Texture0, IN.uv);
}

// this is specific glow downsample
float4 glowBloom(float4 color)
{
    float glowFactor = 1 - color.a;
    float bloomFactor = bloomParams.x * pow(max(max(color.r, color.g), color.b), bloomParams.y);
	return float4(color.rgb, 1) * max(glowFactor, bloomFactor);
}

float4 downSample4x4Glow_ps( VertexOutput_4uv IN ) : COLOR0
{
    float4 gb0 = glowBloom(tex2D(Texture0, IN.uv12.xy));
    float4 gb1 = glowBloom(tex2D(Texture0, IN.uv12.zw));
    float4 gb2 = glowBloom(tex2D(Texture0, IN.uv34.xy));
    float4 gb3 = glowBloom(tex2D(Texture0, IN.uv34.zw));

    return (gb0 + gb1 + gb2 + gb3) * 0.25;
}

float4 downSample4x4Max_ps( VertexOutput_4uv IN ) : COLOR0
{
	float3 avgColor = tex2D( Texture0, IN.uv12.xy ).rgb;
	avgColor = max(avgColor, tex2D( Texture0, IN.uv12.zw ).rgb);
	avgColor = max(avgColor, tex2D( Texture0, IN.uv34.xy ).rgb);
	avgColor = max(avgColor, tex2D( Texture0, IN.uv34.zw ).rgb);

	return float4(avgColor, 1);
}

float4 downSample4x4Avg_ps( VertexOutput_4uv IN ) : COLOR0
{
	float4 avgColor = tex2D( Texture0, IN.uv12.xy );
	avgColor += tex2D( Texture0, IN.uv12.zw );
	avgColor += tex2D( Texture0, IN.uv34.xy );
	avgColor += tex2D( Texture0, IN.uv34.zw );

	return avgColor * 0.25;
}

VertexOutput_4uv downsample4x4_vs(float4 p: POSITION)
{
    float2 uv = convertUv(p);

    VertexOutput_4uv OUT;
    OUT.p = convertPosition(p, 1);
    OUT.uv = uv;

	float2 uvOffset = TextureSize.zw * 0.25f;

	OUT.uv12.xy = uv + uvOffset * float2(-1, -1);
	OUT.uv12.zw = uv + uvOffset * float2(+1, -1);
	OUT.uv34.xy = uv + uvOffset * float2(-1, +1);
	OUT.uv34.zw = uv + uvOffset * float2(+1, +1);

    return OUT;
}

float4 fxCompositing(float2 uv, float glowIntensity)
{
	float4 mainColor = tex2D(Texture0, uv);

	float3 sunShafts = tex2D(Texture2, uv).rgb;
	float4 glow = tex2D(Texture3, uv);

	mainColor.rgb = min(float3(1,1,1), glow.rgb * glowIntensity + mainColor.rgb * (1 - glow.a) );
	mainColor.rgb = 1 - (1 - mainColor.rgb) * (1 - sunShafts);

	return saturate(mainColor);
}

float3 colorCorrection( float3 color )
{
	float3 ret;
    ret.x = dot( color, Params1.xyz ) + Params1.w;
    ret.y = dot( color, Params2.xyz ) + Params2.w;
    ret.z = dot( color, Params3.xyz ) + Params3.w;
    return ret;
}

float4 imageProcess_ps( VertexOutput IN ) : COLOR0
{
	float4 color = tex2D(Texture0, IN.uv);
    return float4( colorCorrection(color.rgb), color.a);
}

float4 imageProcessFXComposition_ps( VertexOutput IN ) : COLOR0
{
	float4 color = fxCompositing(IN.uv, Params4.y);
    return float4(colorCorrection(color.rgb), color.a);
}

float4 imageProcessBlur_ps( VertexOutput IN ) : COLOR0
{
	float3 blurredColor = tex2D(Texture1, IN.uv).rgb;
	float4 color = tex2D(Texture0, IN.uv);
	return float4( colorCorrection(lerp(color.rgb, blurredColor, Params4.x)), color.a);
}

float4 imageProcessBlurFXComposition_ps( VertexOutput IN ) : COLOR0
{
	float3 blurredColor = tex2D(Texture1, IN.uv).rgb;
	float4 color = fxCompositing(IN.uv, Params4.y);
    return float4( colorCorrection(lerp(color.rgb, blurredColor, Params4.x)), color.a);
}

float4 fxCompositing_ps( VertexOutput IN ) : COLOR0
{
	return fxCompositing(IN.uv, Params4.y);
}

float4 gauss(int samples, float2 uv)
{
	float2 step = Params1.xy;
	float sigma = Params1.z;

	float sigmaN = 1 / (2 * sigma * sigma);

	// First sample is in the center and accounts for our pixel
	float4 result = tex2D(Texture0, uv);
	float weight = 1;

	// Every loop iteration computes impact of 4 pixels
	// Each sample computes impact of 2 neighbor pixels, starting with the next one to the right
	// Note that we sample between pixels to leverage bilinear filtering
	for (int i = 0; i < samples; ++i)
	{
		const float ix0 = 2 * i + 1;
		const float ix1 = ix0 + 1;

		float iw0 = exp(-ix0 * ix0 * sigmaN);
		float iw1 = exp(-ix1 * ix1 * sigmaN);
        float iw = iw0 + iw1;
        float ix = ix0 + iw1 / iw;

		result += (tex2D(Texture0, uv + step * ix) + tex2D(Texture0, uv - step * ix)) * iw;
		weight += 2 * iw;
	}

	return (result / weight);
}

float4 blur3_ps(VertexOutput IN): COLOR0
{
	return gauss(3, IN.uv);
}

float4 blur5_ps(VertexOutput IN): COLOR0
{
	return gauss(5, IN.uv);
}

float4 blur7_ps(VertexOutput IN): COLOR0
{
	return gauss(7, IN.uv);
}

float4 ShadowBlurPS(VertexOutput IN): COLOR0
{
#ifdef GLSLES
    const int N = 1;
	const float sigma = 0.5;
#else
    const int N = 3;
	const float sigma = 1.5;
#endif

	const float sigmaN = 1 / (2 * sigma * sigma);

	float2 step = Params1.xy;

    float depth = 1;
    float color = 0;
    float weight = 0;

	for (int i = -N; i <= N; ++i)
	{
        const float ix = i;
		const float iw = exp(-ix * ix * sigmaN);

        float4 data = tex2D(Texture0, IN.uv + step * ix);

        depth = min(depth, data.x);
        color += data.y * iw;
		weight += iw;
	}

    float mask = tex2D(Texture1, IN.uv).r;

	return float4(depth, color * mask * (1 / weight), 0, 0);
}

#define SUN_SHAFTS_SAMPLES 12
#define SUN_SHAFTS_NOISE_RES 8

// intersection of line between texel and sunPos with [-1; 1] 2D quad
float AABQIntersection(float2 texel, float2 sunPos)
{
	float2 texToSun = sunPos - texel;

	float2 t = (sign(texToSun) - texel) / texToSun;
	t.x = t.x < 0 ? 1 : t.x;
	t.y = t.y < 0 ? 1 : t.y;
	return min(min(t.x, t.y), 1);
}

// Optimized HG by disregarding some constants, still could be optimized further if you wish
float henyeyGreenstein(float g, float g2, float cosAngle)
{
	float hg = (1 - g2) * pow(1 + g2 - 2*g*cosAngle, -3.0/2.0); // power could be optimized out, but i like what it does for the looks
	return hg;
}

// Optimization of InvProjectionMat4x4 * float4(NDCCoord.xy,0,1);
float3 NDCToViewSpace(float2 coord)
{
	return normalize(float3(coord * Params4.xy + Params4.zw, -1));
}

/* Mildly inspired by GPU Gems Volumetric Light Scattering as a Post-Process*/
float4 SunRays_ps(VertexOutput_Pos IN): COLOR0
{
	float3 shaftsColor = Params3.rgb;
	float intensity = Params2.x;

	float2 ScreenLightPos = Params1.xy;

	float2 posNDC = IN.pos.xy;
	float2 sunPosNDC = ScreenLightPos.xy;
	float2 dirNCD = posNDC - sunPosNDC;
#ifndef GLSL
	dirNCD.y *= -1;
#endif

	float2 deltaTexCoord = dirNCD * 0.5; // *0.5 to go to Tex space
	deltaTexCoord *= AABQIntersection(posNDC, sunPosNDC);
	deltaTexCoord *= 1.0f / SUN_SHAFTS_SAMPLES ;  

	float2 texCoord = IN.uv;
	float noiseSample = tex2D(Texture1, texCoord * TextureSize.xy / 8).r;
 	texCoord += deltaTexCoord * noiseSample;

	float value = 0;
	for (int i = 0; i < SUN_SHAFTS_SAMPLES; i++)  
	{
		texCoord -= deltaTexCoord;
		value += (tex2D(Texture0, texCoord).r >= 0.999);
	}  

	float3 viewDir = NDCToViewSpace(posNDC);
	float3 sunDirViewSpace = float3(Params1.zw, Params2.w);
	float cosAngle = dot(viewDir, sunDirViewSpace);
 
	return float4(shaftsColor * (value * intensity * henyeyGreenstein(Params2.y, Params2.z, cosAngle)), 1);  
}

#define RADIAL_BLUR_SAMPLES 12
float4 RadialBlur_ps(VertexOutput_Pos IN): COLOR0
{
	float2 texCoord = (IN.uv);

	float2 posNDC = IN.pos.xy;
	float2 blurCenterNDC = Params1.xy;
	float2 dirNDC = posNDC - blurCenterNDC;
#ifndef GLSL
	dirNDC.y *= -1;
#endif

	float2 deltaTexCoord = dirNDC * 0.5;  
	deltaTexCoord *= AABQIntersection(posNDC, blurCenterNDC);
	deltaTexCoord *= 1.0 / RADIAL_BLUR_SAMPLES * 0.5;  

	float3 sum = float3(0,0,0);
	for (int i = 0; i < RADIAL_BLUR_SAMPLES; i++)  
	{
		texCoord -= deltaTexCoord;
		sum += tex2D(Texture0, texCoord).rgb;
	}
	return float4(sum / RADIAL_BLUR_SAMPLES, 1);  
}

