Shader "Optimised/RGBATexBlend/RGBATexBlendBump" {
	Properties {
		_RedTex ("Diffuse (Red)(RGB)", 2D) = "white" {}
		_RedBump ("Normal (Red)(RGB)", 2D) = "bump" {}
		_GreenTex ("Diffuse (Green)(RGB)", 2D) = "white" {}
		_GreenBump ("Normal (Green)(RGB)", 2D) = "bump" {}
		_BlueTex ("Diffuse (Blue)(RGB)", 2D) = "white" {}
		_BlueBump ("Normal (Blue)(RGB)", 2D) = "bump" {}
		_AlphaTex ("Diffuse (Alpha)(RGB)", 2D) = "white" {}
		_AlphaBump ("Normal (Alpha)(RGB)", 2D) = "bump" {}
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 300
		
		CGPROGRAM
		#pragma surface surf LambertMobile addshadow fullforwardshadows
		#include "../MobileLighting.cginc"
		#pragma target 3.0
		//Shader Model 3.0+ only

		sampler2D _RedTex;
		sampler2D _RedBump;
		sampler2D _GreenTex;
		sampler2D _GreenBump;
		sampler2D _BlueTex;
		sampler2D _BlueBump;
		sampler2D _AlphaTex;
		sampler2D _AlphaBump;

		struct Input {
			fixed4 color : COLOR;
			fixed2 uv_RedTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			
			o.Albedo = ((tex2D(_RedTex, IN.uv_RedTex))*IN.color.r)
					  +((tex2D(_GreenTex, IN.uv_RedTex))*IN.color.g)
					  +((tex2D(_BlueTex, IN.uv_RedTex))*IN.color.b)
					  +((tex2D(_AlphaTex, IN.uv_RedTex))*IN.color.a);
			
			o.Normal = ((UnpackNormal(tex2D(_RedBump, IN.uv_RedTex)))*IN.color.r)
					  +((UnpackNormal(tex2D(_GreenBump, IN.uv_RedTex)))*IN.color.g)
					  +((UnpackNormal(tex2D(_BlueBump, IN.uv_RedTex)))*IN.color.b)
					  +((UnpackNormal(tex2D(_AlphaBump, IN.uv_RedTex)))*IN.color.a);
		}
		ENDCG
	} 
	FallBack "Hotgen/RGBATexBlend/RGBATexBlend"
}
