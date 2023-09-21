#include "screenspace.hlsl"

float4 glowApply_ps( VertexOutput IN ) : COLOR0
{
	float4 color = tex2D(tex, IN.uv);
	return float4(color.rgb * Params.x, color.a);
}

// this is specific glow downsample
float4 downSample4x4Glow_ps( VertexOutput_4uv IN ) : COLOR0
{
	float4 avgColor = tex2D( tex, IN.uv12.xy );
	avgColor += tex2D( tex, IN.uv12.zw );
	avgColor += tex2D( tex, IN.uv34.xy );
	avgColor += tex2D( tex, IN.uv34.zw );

	avgColor *= 0.25;
	return float4(avgColor.rgb, 1) * (1-avgColor.a);
}
