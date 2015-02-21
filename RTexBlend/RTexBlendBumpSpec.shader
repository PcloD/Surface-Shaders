Shader "Optimised/RTexBlend/RTexBlendBumpSpec" {
	Properties {
		_BlackTex ("Diffuse (Black)(RGB) Specular (A)", 2D) = "white" {}
		_BlackBump ("Normal (Black)(RGB)", 2D) = "bump" {}
		_BlackShininess ("Shininess (Black)", Range (0.03, 1)) = 1
		_WhiteTex ("Diffuse (White)(RGB) Specular (A)", 2D) = "white" {}
		_WhiteBump ("Normal (White)(RGB)", 2D) = "bump" {}
		_WhiteShininess ("Shininess (White)", Range (0.03, 1)) = 1
		_SpecColor ("Specular Color (RGB)", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 400
		
		CGPROGRAM
		#pragma surface surf BlinnPhongMobile addshadow fullforwardshadows approxview
		#include "../MobileLighting.cginc"
		#pragma target 3.0 
		//Shader Model 3.0+ only

		sampler2D _BlackTex;
		sampler2D _BlackBump;
		sampler2D _WhiteTex;
		sampler2D _WhiteBump;
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
			o.Normal = lerp((UnpackNormal(tex2D(_BlackBump, IN.uv_BlackTex))), (UnpackNormal(tex2D(_WhiteBump, IN.uv_BlackTex))), IN.color.r);
		}
		ENDCG
	} 
	FallBack "Hotgen/RTexBlend/RTexBlend"
}
