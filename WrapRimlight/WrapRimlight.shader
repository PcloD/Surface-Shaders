Shader "Optimised/WrapRimlight/WrapRimlight" {
	Properties {
		_MainTex ("Diffuse (RGB)", 2D) = "white" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
		_RimColor ("Rim Color (RGB)", Color) = (1,1,1,1)
		_RimStrength ("Rim Strength", Range (0, 5)) = 0.5
		_RimWidth ("Rim Width", Range (0, 5)) = 0.5
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf LambertWrapMobile addshadow fullforwardshadows
		#include "../MobileLighting.cginc"
		//#pragma target 3.0 //Uncomment this when too many parameters cause compile to fail, Shader Model 3.0+ only

		sampler2D _MainTex;
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
		  fixed rim = (1.0 - saturate(dot (normalize(IN.viewDir), o.Normal)))*_RimStrength;
          o.Emission = _RimColor.rgb * pow (rim, _RimWidth);
          
		}
		ENDCG
	} 
	//FallBack "Diffuse"
}
