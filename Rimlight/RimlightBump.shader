Shader "Optimised/Rimlight/RimlightBump" {
	Properties {
		_MainTex ("Diffuse (RGB)", 2D) = "white" {}
		_BumpMap ("Normal Map (RGB)", 2D) = "bump" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
		_RimColor ("Rim Color (RGB)", Color) = (1,1,1,1)
		_RimStrength ("Rim Strength", Range (0, 5)) = 0.5
		_RimWidth ("Rim Width", Range (0, 5)) = 0.5
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 300
		
		CGPROGRAM
		#pragma surface surf LambertMobile addshadow fullforwardshadows approxview
		#include "../MobileLighting.cginc"
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BumpMap;
        fixed3 _Color;
        fixed3 _RimColor;
		fixed _RimStrength;            
        fixed _RimWidth;
                
		struct Input {
			fixed2 uv_MainTex;
			fixed3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		
		  o.Albedo = (tex2D(_MainTex, IN.uv_MainTex)).rgb * _Color.rgb;
          o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
          fixed rim = (1.0 - saturate(dot (normalize(IN.viewDir), o.Normal)))*_RimStrength;
          o.Emission = _RimColor.rgb * pow (rim, _RimWidth);
          
		}
		ENDCG
	} 
	FallBack "Hotgen/Rimlight/Rimlight"
}
