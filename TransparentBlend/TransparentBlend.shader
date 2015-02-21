Shader "Optimised/TransparentBlend/TransparentBlend" {
	Properties {
		_MainTex ("Diffuse (RGB) Transparency (A)", 2D) = "white" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
		_Transparency ("Transparency", Range (-1, 1)) = 0.0
	}
	SubShader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		LOD 200
		ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha //blend
        
		Cull Front
		CGPROGRAM
		#pragma surface surf LambertMobile addshadow fullforwardshadows
		#include "../MobileLighting.cginc"
		//#pragma target 3.0 //Uncomment this when too many parameters cause compile to fail, Shader Model 3.0+ only

		sampler2D _MainTex;
        fixed3 _Color;
        fixed _Transparency;
                
		struct Input {
			fixed2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		
		  o.Albedo = (tex2D(_MainTex, IN.uv_MainTex)).rgb * _Color.rgb;
          o.Alpha = (tex2D(_MainTex, IN.uv_MainTex)).a + _Transparency;
		}
		ENDCG
		
		Cull Back
		CGPROGRAM
		#pragma surface surf LambertMobile addshadow fullforwardshadows
		#include "../MobileLighting.cginc"
		//#pragma target 3.0 //Uncomment this when too many parameters cause compile to fail, Shader Model 3.0+ only

		sampler2D _MainTex;
        fixed3 _Color;
        fixed _Transparency;
                
		struct Input {
			fixed2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		
		  o.Albedo = (tex2D(_MainTex, IN.uv_MainTex)).rgb * _Color.rgb;
          o.Alpha = (tex2D(_MainTex, IN.uv_MainTex)).a + _Transparency;
		}
		ENDCG
	} 
	//FallBack "Diffuse"
}
