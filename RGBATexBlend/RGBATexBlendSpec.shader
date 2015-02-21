Shader "Optimised/RGBATexBlend/RGBATexBlendSpec" {
	Properties {
		_RedTex ("Diffuse (Red)(RGB) Specular (A)", 2D) = "white" {}
		_RedShininess ("Shininess (Red)", Range (0.03, 1)) = 1
		_GreenTex ("Diffuse (Green)(RGB) Specular (A)", 2D) = "white" {}
		_GreenShininess ("Shininess (Green)", Range (0.03, 1)) = 1
		_BlueTex ("Diffuse (Blue)(RGB) Specular (A)", 2D) = "white" {}
		_BlueShininess ("Shininess (Blue)", Range (0.03, 1)) = 1
		_AlphaTex ("Diffuse (Alpha)(RGB) Specular (A)", 2D) = "white" {}
		_AlphaShininess ("Shininess (Alpha)", Range (0.03, 1)) = 1
		_SpecColor ("Specular Color (RGB)", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 300
		
		CGPROGRAM
		#pragma surface surf BlinnPhongMobile addshadow fullforwardshadows approxview
		#include "../MobileLighting.cginc"
		#pragma target 3.0
		//Shader Model 3.0+ only

		sampler2D _RedTex;
		sampler2D _GreenTex;
		sampler2D _BlueTex;
		sampler2D _AlphaTex;
		fixed _RedShininess;
		fixed _GreenShininess;
		fixed _BlueShininess;
		fixed _AlphaShininess;

		struct Input {
			fixed4 color : COLOR;
			fixed2 uv_RedTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			
			o.Albedo = ((tex2D(_RedTex, IN.uv_RedTex))*IN.color.r)
					  +((tex2D(_GreenTex, IN.uv_RedTex))*IN.color.g)
					  +((tex2D(_BlueTex, IN.uv_RedTex))*IN.color.b)
					  +((tex2D(_AlphaTex, IN.uv_RedTex))*IN.color.a);
					  
			o.Gloss = ((tex2D(_RedTex, IN.uv_RedTex)).a*IN.color.r)
					  +((tex2D(_GreenTex, IN.uv_RedTex)).a*IN.color.g)
					  +((tex2D(_BlueTex, IN.uv_RedTex)).a*IN.color.b)
					  +((tex2D(_AlphaTex, IN.uv_RedTex)).a*IN.color.a);
					  
			o.Specular = (_RedShininess*(tex2D(_RedTex, IN.uv_RedTex)).a*IN.color.r)
					    +(_GreenShininess*(tex2D(_GreenTex, IN.uv_RedTex)).a*IN.color.g)
					    +(_BlueShininess*(tex2D(_BlueTex, IN.uv_RedTex)).a*IN.color.b)
					    +(_AlphaShininess*(tex2D(_AlphaTex, IN.uv_RedTex)).a*IN.color.a);
		}
		ENDCG
	} 
	FallBack "Hotgen/RGBATexBlend/RGBATexBlend"
}
