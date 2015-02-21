Shader "Optimised/RTexBlend/RTexBlend" {
	Properties {
		_BlackTex ("Diffuse (Black)(RGB)", 2D) = "white" {}
		_WhiteTex ("Diffuse (White)(RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf LambertMobile addshadow fullforwardshadows
		#include "../MobileLighting.cginc"
		//#pragma target 3.0 //Uncomment this when too many parameters cause compile to fail, Shader Model 3.0+ only

		sampler2D _BlackTex;
		sampler2D _WhiteTex;

		struct Input {
			fixed4 color : COLOR;
			fixed2 uv_BlackTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			
			o.Albedo = lerp((tex2D(_BlackTex, IN.uv_BlackTex)), (tex2D(_WhiteTex, IN.uv_BlackTex)), IN.color.r);
		}
		ENDCG
	} 
	//FallBack "Diffuse"
}
