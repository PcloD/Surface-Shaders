Shader "Optimised/Wrap/WrapBump" {
	Properties {
		_MainTex ("Diffuse (RGB)", 2D) = "white" {}
		_BumpMap ("Normal Map (RGB)", 2D) = "bump" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 300
		
		CGPROGRAM
		#pragma surface surf LambertWrapMobile addshadow fullforwardshadows
		#include "../MobileLighting.cginc"
		#pragma target 3.0
		//Shader Model 3.0+ only
		
		sampler2D _MainTex;
		sampler2D _BumpMap;
        fixed3 _Color;
              
		struct Input {
			fixed2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		
		  o.Albedo = (tex2D(_MainTex, IN.uv_MainTex)).rgb * _Color.rgb;
          o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
          
		}
		ENDCG
	} 
	FallBack "Hotgen/Wrap/Wrap"
}
