Shader "Optimised/Wrap/WrapBumpSpec" {
	Properties {
		_MainTex ("Diffuse (RGB) Specular (A)", 2D) = "white" {}
		_BumpMap ("Normal Map (RGB)", 2D) = "bump" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
		_SpecColor ("Specular Color (RGB)", Color) = (1,1,1,1)
		_Shininess ("Shininess", Range (0.03, 1)) = 1
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 300
		
		CGPROGRAM
		#pragma surface surf BlinnPhongWrapMobile addshadow fullforwardshadows approxview
		#include "../MobileLighting.cginc"
		#pragma target 3.0
		//Shader Model 3.0+ only

    	fixed _Shininess;
    	sampler2D _MainTex;
    	fixed3 _Color;
    	sampler2D _BumpMap;  
    
    	struct Input {
			fixed2 uv_MainTex;
		};                                                                                  
                                                                                                                                                                                                                                                                                         
		void surf (Input IN, inout SurfaceOutput o) {
		
		  o.Albedo = (tex2D(_MainTex, IN.uv_MainTex)).rgb * _Color.rgb;
		  o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
		  o.Gloss = (tex2D(_MainTex, IN.uv_MainTex)).a;
          o.Specular = (tex2D(_MainTex, IN.uv_MainTex)).a;
          
		}
				
		ENDCG
	} 
	FallBack "Hotgen/Wrap/Wrap"
}
