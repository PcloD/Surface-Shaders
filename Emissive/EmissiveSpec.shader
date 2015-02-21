Shader "Optimised/Emissive/EmissiveSpec" {
	Properties {
		_MainTex ("Diffuse (RGB) Specular (A)", 2D) = "white" {}
		_Emission ("Emission (RGB)", 2D) = "Black" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
		_SpecColor ("Specular Color (RGB)", Color) = (1,1,1,1)
		_Shininess ("Shininess", Range (0.03, 1)) = 1
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 300
		
		CGPROGRAM
		#pragma surface surf BlinnPhongMobile addshadow fullforwardshadows
		#include "../MobileLighting.cginc"
		//#pragma target 3.0 //Uncomment this when too many parameters cause compile to fail, Shader Model 3.0+ only

		sampler2D _MainTex;
		sampler2D _Emission;
        fixed3 _Color;
        fixed _Shininess;
                
		struct Input {
			fixed2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		
		  o.Albedo = (tex2D(_MainTex, IN.uv_MainTex)).rgb * _Color.rgb;
		  o.Gloss = (tex2D(_MainTex, IN.uv_MainTex)).a;
          o.Specular = _Shininess * (tex2D(_MainTex, IN.uv_MainTex)).a;
          o.Emission = (tex2D(_Emission, IN.uv_MainTex)).rgb;
          
		}
		ENDCG
	} 
	FallBack "Hotgen/Emissive/Emissive"
}
