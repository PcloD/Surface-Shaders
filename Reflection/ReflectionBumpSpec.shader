﻿Shader "Optimised/Reflection/ReflectionBumpSpec" {
	Properties {
		_MainTex ("Diffuse (RGB) Specular (A)", 2D) = "white" {}
		_BumpMap ("Normal Map (RGB)", 2D) = "bump" {}
		_Cube ("Cubemap", CUBE) = "" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
		_SpecColor ("Specular Color (RGB)", Color) = (1,1,1,1)
		_Shininess ("Shininess", Range (0.03, 1)) = 1
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 400
		
		CGPROGRAM
		#pragma surface surf BlinnPhongMobile addshadow fullforwardshadows approxview
		#include "../MobileLighting.cginc"
		#pragma target 3.0
		
		struct Input {
			fixed2 uv_MainTex;
			fixed3 worldRefl;
        	INTERNAL_DATA
		};
		
		sampler2D _MainTex;
		sampler2D _BumpMap;
        samplerCUBE _Cube;
        fixed3 _Color;
        fixed _Shininess;
                        
		void surf (Input IN, inout SurfaceOutput o) {
		
		  o.Albedo = (tex2D(_MainTex, IN.uv_MainTex)).rgb * _Color.rgb;
		  o.Gloss = (tex2D(_MainTex, IN.uv_MainTex)).a;
          o.Specular = _Shininess * (tex2D(_MainTex, IN.uv_MainTex)).a;
          o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
          o.Emission = texCUBE (_Cube, WorldReflectionVector (IN, o.Normal)).rgb;
          
		}
		ENDCG
	} 
	FallBack "Hotgen/Reflection/Reflection"
}
