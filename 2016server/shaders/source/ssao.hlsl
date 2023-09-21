#include "screenspace.hlsl"

// ao sampling
#define SSAO_NUM_PAIRS 8
#define SSAO_RADIUS 2
#define SSAO_MIN_PIXELS 10
#define SSAO_MAX_PIXELS 100
#define SSAO_MIP_OFFSET 2

// ao tuning
#define SSAO_OVERSHADOW 0.75
#define SSAO_ANGLELIMIT 0.1
#define SSAO_BOOST 1

// blur tuning
#define SSAO_BLUR_SAMPLES 3
#define SSAO_BLUR_STRENGTH 1.5
#define SSAO_BLUR_DEPTH_THRESHOLD 0.4

// composite tuning
#define SSAO_DEPTH_THRESHOLD_CENTER 0.02
#define SSAO_DEPTH_THRESHOLD_ESTIMATE 0.4

TEX_DECLARE2D(depthBuffer, 0);
TEX_DECLARE2D(randMap, 1);
TEX_DECLARE2D(map, 2);
TEX_DECLARE2D(geomMap, 3);

uniform float4 Params;

float4 SSAODepthDownPS(float4 pos: POSITION, float2 uv: TEXCOORD0) : COLOR0
{
    float d0 = tex2D(geomMap, uv + TextureSize.zw * float2(-0.25, -0.25)).r;
    float d1 = tex2D(geomMap, uv + TextureSize.zw * float2(+0.25, -0.25)).r;
    float d2 = tex2D(geomMap, uv + TextureSize.zw * float2(-0.25, +0.25)).r;
    float d3 = tex2D(geomMap, uv + TextureSize.zw * float2(+0.25, +0.25)).r;

	return min(min(d0, d3), min(d1, d2));
}

float getSampleLength(float i)
{
	return (i+1) / (SSAO_NUM_PAIRS+2);
}

float2 getSampleRotation(float i)
{
	float pi = 3.1415926;

	return float2(cos(i / SSAO_NUM_PAIRS * 2 * pi), sin (i / SSAO_NUM_PAIRS * 2 * pi));
}

float4 SSAOPS(float4 pos: POSITION, float2 uv: TEXCOORD0): COLOR0
{
	float baseDepth = tex2Dlod(depthBuffer, float4(uv, 0, 0)).r;

	float4 noiseTex = tex2D(randMap, frac(uv*TextureSize.xy /4))*2-1;
	
	float2x2 rotation = 
	{
		{ noiseTex.y, noiseTex.x },
		{ -noiseTex.x, noiseTex.y }
	};
	
	const float sphereRadiusZB = SSAO_RADIUS / GBUFFER_MAX_DEPTH;
	
	float2 radiusTex = clamp(sphereRadiusZB / baseDepth * Params.xy, SSAO_MIN_PIXELS * TextureSize.zw, SSAO_MAX_PIXELS * TextureSize.zw);
	
    float lod = log2(getSampleLength(0) * length(radiusTex * TextureSize.xy)) - SSAO_MIP_OFFSET;

	float result = 1; // center pixel
	float weight = 2;

	for (int i = 0; i < SSAO_NUM_PAIRS; i++)
	{
		const float offsetLength = getSampleLength(i);
		const float2 offsetVector = getSampleRotation(i) * offsetLength;
		const float segmentDiff = sphereRadiusZB * sqrt(1 - offsetLength*offsetLength);
        const float angleLimit = offsetLength * SSAO_ANGLELIMIT;

		float2 offset = mul(rotation, offsetVector) * radiusTex;
	
		float2 offsetDepth;
		offsetDepth.x = tex2Dlod(depthBuffer, float4(uv + offset, 0, lod)).r;
		offsetDepth.y = tex2Dlod(depthBuffer, float4(uv - offset, 0, lod)).r;
		
		float2 diff = offsetDepth - baseDepth.xx;
		
		// 0 is the near surface of the sphere, 1 is the far surface, 0.5 is the middle
		float2 normalizedDiff = diff * (1 / segmentDiff * 0.5) + 0.5;

		// only add sample contribution if both samples are visible - if one is invisible we estimate the twin as 1-s so sum is 1
		float sampleadd = saturate(min(normalizedDiff.x, normalizedDiff.y) + SSAO_OVERSHADOW);

		result += (saturate(normalizedDiff.x + angleLimit) + saturate(normalizedDiff.y + angleLimit)) * sampleadd;
		weight += 2 * sampleadd;
 	}
	
	// rescale result from 0..0.5 to 0..1 and apply a power function
	float finalocc = (baseDepth > 0.99) ? 1 : pow(saturate(result / weight * 2), SSAO_BOOST);
	
	return float4(finalocc, baseDepth, 0, 1);
}

float2 ssaoBlur(float2 uv, float2 offset, TEXTURE_IN_2D(map))
{
	float sigmaN = 1 / (2 * SSAO_BLUR_STRENGTH * SSAO_BLUR_STRENGTH);

	float baseDepth = tex2D(map, uv).g;

	const float sphereRadiusZB = SSAO_BLUR_DEPTH_THRESHOLD / GBUFFER_MAX_DEPTH;

    float depthTolerance = clamp((baseDepth * 80) * sphereRadiusZB, 0.1 * sphereRadiusZB, 10 * sphereRadiusZB);

    float result = 0;
    float weight = 0;

	for (int i = -SSAO_BLUR_SAMPLES; i <= SSAO_BLUR_SAMPLES; ++i)
	{
        const float ix = i;
		const float iw = exp(-ix * ix * sigmaN);

        float4 data = tex2D(map, uv + offset * ix);

		float w = iw * (abs(data.g - baseDepth) < depthTolerance);

		result += data.r * w;
		weight += w;
	}

	return float2(result / weight, baseDepth);
}

float4 SSAOBlurXPS(float4 pos: POSITION, float2 uv : TEXCOORD0): COLOR0
{
    float2 o = float2(TextureSize.z, 0);

    float2 ssaoTerm = ssaoBlur(uv, o, TEXTURE(map));

    return float4(ssaoTerm, 0, 1);
}

float4 SSAOBlurYPS(float4 pos: POSITION, float2 uv : TEXCOORD0): COLOR0
{
    float2 o = float2(0, TextureSize.w);

    float2 ssaoTerm = ssaoBlur(uv, o, TEXTURE(map));

    return float4(ssaoTerm, 0, 1);
}

VertexOutput_4uv SSAOCompositVS(float4 p: POSITION)
{
    float2 uv = convertUv(p);

    VertexOutput_4uv OUT;
    OUT.p = convertPosition(p, 1);
    OUT.uv = uv;

	float2 uvOffset = TextureSize.zw * 2;

	OUT.uv12.xy = uv + float2(uvOffset.x, 0);
	OUT.uv12.zw = uv - float2(uvOffset.x, 0);
	OUT.uv34.xy = uv + float2(0, uvOffset.y);
	OUT.uv34.zw = uv - float2(0, uvOffset.y);

    return OUT;
}
 
float4 SSAOCompositPS(VertexOutput_4uv IN): COLOR0
{
    float4 geom = tex2D(geomMap, IN.uv);
	float4 mapC = tex2D(map, IN.uv);
	float4 map0 = tex2D(map, IN.uv12.xy);
	float4 map1 = tex2D(map, IN.uv12.zw);
	float4 map2 = tex2D(map, IN.uv34.xy);
	float4 map3 = tex2D(map, IN.uv34.zw);

	float baseDepth = geom.r;

	float ssaoC = mapC.r;
	float depthC = mapC.g;

	float4 ssaoEst = float4(map0.r, map1.r, map2.r, map3.r);
	float4 depthEst = float4(map0.g, map1.g, map2.g, map3.g);

	// can we trust the neighbors? 1 - yes, 0 - no
	float4 checkEst = abs(depthEst - baseDepth) < SSAO_DEPTH_THRESHOLD_ESTIMATE / GBUFFER_MAX_DEPTH;
	
	float checkEstSum = dot(checkEst, 1);
	float ssaoTermEst = dot(ssaoEst, checkEst) / checkEstSum;

	// the final decision: pick the estimate sample if there are good neighbors and base depth is not trustworthy
	float ssaoTerm = abs(depthC - baseDepth) * checkEstSum > SSAO_DEPTH_THRESHOLD_CENTER / GBUFFER_MAX_DEPTH ? ssaoTermEst : ssaoC;

    // AO reduction for high specular and diffuse values. Computed in gbufferPack in common.h
	float slope = geom.g;

	return float4((1 - slope) * ssaoTerm.xxx + slope, 1);
}
