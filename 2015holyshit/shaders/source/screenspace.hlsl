#include "common.h"

TEX_DECLARE2D(tex, 0);

// .xy = gbuffer width/height, .zw = inverse gbuffer width/height
uniform float4 TextureSize;
uniform float4 Params;

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

float4 passThrough_ps( VertexOutput IN ) : COLOR0
{
	return tex2D(tex, IN.uv);
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

float4 blur_ps(VertexOutput IN): COLOR0
{
	float2 step = Params.xy;
	float sigma = Params.z;

	float sigmaN1 = 1 / sqrt(2 * 3.1415926 * sigma * sigma);
	float sigmaN2 = 1 / (2 * sigma * sigma);

	// First sample is in the center and accounts for our pixel
	float4 result = tex2D(tex, IN.uv) * sigmaN1;
	float weight = sigmaN1;

	// Every loop iteration computes impact of 4 pixels
	// Each sample computes impact of 2 neighbor pixels, starting with the next one to the right
	// Note that we sample exactly in between pixels to leverage bilinear filtering
	for (int i = 0; i < 3; ++i)
	{
		float ix = 2 * i + 1.5;
		float iw = 2 * exp(-ix * ix * sigmaN2) * sigmaN1;

		result += (tex2D(tex, IN.uv + step * ix) + tex2D(tex, IN.uv - step * ix)) * iw;
		weight += 2 * iw;
	}

	// Since the above is an approximation of the integral with step functions, normalization compensates for the error
	return result / weight;
}