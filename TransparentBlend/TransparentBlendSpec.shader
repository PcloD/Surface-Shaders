﻿Shader "Optimised/TransparentBlend/TransparentBlendSpec" {
	Properties {
		_MainTex ("Diffuse (RGB) Transparency (A)", 2D) = "white" {}
		_SpecTex ("Specular (R)", 2D) = "white" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
		_SpecColor ("Specular Color (RGB)", Color) = (1,1,1,1)
		_Shininess ("Shininess", Range (0.03, 1)) = 1
		_Transparency ("Transparency", Range (-1, 1)) = 0.0
	}
	SubShader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		LOD 300
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha //blend
		
		Cull Front
		CGPROGRAM
		#pragma surface surf BlinnPhongMobile addshadow fullforwardshadows approxview
		#include "../MobileLighting.cginc"
		#pragma target 3.0
		//Shader Model 3.0+ only

		sampler2D _MainTex;
		sampler2D _SpecTex;
        fixed3 _Color;
        fixed _Shininess;
        fixed _Transparency;
                
		struct Input {
			fixed2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		
		  o.Albedo = (tex2D(_MainTex, IN.uv_MainTex)).rgb * _Color.rgb;
		  o.Gloss = (tex2D(_SpecTex, IN.uv_MainTex)).r*(tex2D(_MainTex, IN.uv_MainTex)).a;
          o.Specular = _Shininess * (tex2D(_SpecTex, IN.uv_MainTex)).r*(tex2D(_MainTex, IN.uv_MainTex)).a;
          o.Alpha = (tex2D(_MainTex, IN.uv_MainTex)).a + _Transparency;
          
		}
		ENDCG
		
		Cull Back
		CGPROGRAM
		#pragma surface surf BlinnPhongMobile addshadow fullforwardshadows approxview
		#include "../MobileLighting.cginc"
		#pragma target 3.0
		//Shader Model 3.0+ only

		sampler2D _MainTex;
		sampler2D _SpecTex;
        fixed3 _Color;
        fixed _Shininess;
        fixed _Transparency;
                
		struct Input {
			fixed2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		
		  o.Albedo = (tex2D(_MainTex, IN.uv_MainTex)).rgb * _Color.rgb;
		  o.Gloss = (tex2D(_SpecTex, IN.uv_MainTex)).r*(tex2D(_MainTex, IN.uv_MainTex)).a;
          o.Specular = _Shininess * (tex2D(_SpecTex, IN.uv_MainTex)).r*(tex2D(_MainTex, IN.uv_MainTex)).a;
          o.Alpha = (tex2D(_MainTex, IN.uv_MainTex)).a + _Transparency;
          
		}
		ENDCG
	} 
	FallBack "Hotgen/TransparentBlend/TransparentBlend"
}
