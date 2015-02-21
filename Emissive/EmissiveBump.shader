Shader "Optimised/Emissive/EmissiveBump" {
	Properties {
		_MainTex ("Diffuse (RGB)", 2D) = "white" {}
		_BumpMap ("Normal Map (RGB)", 2D) = "bump" {}
		_Emission ("Emission (RGB)", 2D) = "Black" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 300
		
		CGPROGRAM
		#pragma surface surf LambertMobile addshadow fullforwardshadows
		#include "../MobileLighting.cginc"
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _Emission;
        fixed3 _Color;
                
		struct Input {
			fixed2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		
		  o.Albedo = (tex2D(_MainTex, IN.uv_MainTex)).rgb * _Color.rgb;
          o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
          o.Emission = (tex2D(_Emission, IN.uv_MainTex)).rgb;
          
		}
		ENDCG
	} 
	FallBack "Hotgen/Emissive/Emissive"
}
