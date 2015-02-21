Shader "Optimised/RTexBlend/RTexBlendBump" {
	Properties {
		_BlackTex ("Diffuse (Black)(RGB)", 2D) = "white" {}
		_BlackBump ("Normal (Black)(RGB)", 2D) = "bump" {}
		_WhiteTex ("Diffuse (White)(RGB)", 2D) = "white" {}
		_WhiteBump ("Normal (White)(RGB)", 2D) = "bump" {}
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 300
		
		CGPROGRAM
		#pragma surface surf LambertMobile addshadow fullforwardshadows
		#include "../MobileLighting.cginc"
		//#pragma target 3.0 //Uncomment this when too many parameters cause compile to fail, Shader Model 3.0+ only

		sampler2D _BlackTex;
		sampler2D _BlackBump;
		sampler2D _WhiteTex;
		sampler2D _WhiteBump;

		struct Input {
			fixed4 color : COLOR;
			fixed2 uv_BlackTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			
			o.Albedo = lerp((tex2D(_BlackTex, IN.uv_BlackTex)), (tex2D(_WhiteTex, IN.uv_BlackTex)), IN.color.r);
			o.Normal = lerp((UnpackNormal(tex2D(_BlackBump, IN.uv_BlackTex))), (UnpackNormal(tex2D(_WhiteBump, IN.uv_BlackTex))), IN.color.r);
		}
		ENDCG
	} 
	FallBack "Hotgen/RTexBlend/RTexBlend"
}
