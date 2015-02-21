Shader "Optimised/TransparentBlendCull/TransparentBlendCullBump" {
	Properties {
		_MainTex ("Diffuse (RGB) Transparency (A)", 2D) = "white" {}
		_BumpMap ("Normal Map (RGB)", 2D) = "bump" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
		_Transparency ("Transparency", Range (-1, 1)) = 0.0
	}
	SubShader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		LOD 300
		Cull Back
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha //blend
		
		CGPROGRAM
		#pragma surface surf LambertMobile addshadow fullforwardshadows
		#include "../MobileLighting.cginc"
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BumpMap;
        fixed3 _Color;
        fixed _Transparency;
                
		struct Input {
			fixed2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		
		  o.Albedo = (tex2D(_MainTex, IN.uv_MainTex)).rgb * _Color.rgb;
		  o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
          o.Alpha = (tex2D(_MainTex, IN.uv_MainTex)).a + _Transparency;
          
		}
		ENDCG
	} 
	FallBack "Hotgen/TransparentBlendCull/TransparentBlendCull"
}
