Shader "Optimised/RTexBlend/RTexBlendSpec" {
	Properties {
		_BlackTex ("Diffuse (Black)(RGB) Specular (A)", 2D) = "white" {}
		_BlackShininess ("Shininess (Black)", Range (0.03, 1)) = 1
		_WhiteTex ("Diffuse (White)(RGB) Specular (A)", 2D) = "white" {}
		_WhiteShininess ("Shininess (White)", Range (0.03, 1)) = 1
		_SpecColor ("Specular Color (RGB)", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 300
		
		CGPROGRAM
		#pragma surface surf BlinnPhongMobile addshadow fullforwardshadows
		#include "../MobileLighting.cginc"
		//#pragma target 3.0 //Uncomment this when too many parameters cause compile to fail, Shader Model 3.0+ only

		sampler2D _BlackTex;
		sampler2D _WhiteTex;
		fixed _BlackShininess;
		fixed _WhiteShininess;

		struct Input {
			fixed4 color : COLOR;
			fixed2 uv_BlackTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			
			o.Albedo = lerp((tex2D(_BlackTex, IN.uv_BlackTex)), (tex2D(_WhiteTex, IN.uv_BlackTex)), IN.color.r);
			o.Gloss = lerp((tex2D(_BlackTex, IN.uv_BlackTex)).a, (tex2D(_WhiteTex, IN.uv_BlackTex)).a, IN.color.r);
			o.Specular = lerp(_BlackShininess*(tex2D(_BlackTex, IN.uv_BlackTex)).a, _WhiteShininess*(tex2D(_WhiteTex, IN.uv_BlackTex)).a, IN.color.r);
		}
		ENDCG
	} 
	FallBack "Hotgen/RTexBlend/RTexBlend"
}
