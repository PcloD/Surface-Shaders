Shader "Optimised/RGBATexBlend/RGBATexBlend" {
	Properties {
		_RedTex ("Diffuse (Red)(RGB)", 2D) = "white" {}
		_GreenTex ("Diffuse (Green)(RGB)", 2D) = "white" {}
		_BlueTex ("Diffuse (Blue)(RGB)", 2D) = "white" {}
		_AlphaTex ("Diffuse (Alpha)(RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf LambertMobile addshadow fullforwardshadows
		#include "../MobileLighting.cginc"
		//#pragma target 3.0 //Uncomment this when too many parameters cause compile to fail, Shader Model 3.0+ only

		sampler2D _RedTex;
		sampler2D _GreenTex;
		sampler2D _BlueTex;
		sampler2D _AlphaTex;

		struct Input {
			fixed4 color : COLOR;
			fixed2 uv_RedTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			
			o.Albedo = ((tex2D(_RedTex, IN.uv_RedTex))*IN.color.r)
					  +((tex2D(_GreenTex, IN.uv_RedTex))*IN.color.g)
					  +((tex2D(_BlueTex, IN.uv_RedTex))*IN.color.b)
					  +((tex2D(_AlphaTex, IN.uv_RedTex))*IN.color.a);
		}
		ENDCG
	} 
	//FallBack "Diffuse"
}
