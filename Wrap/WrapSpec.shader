Shader "Optimised/Wrap/WrapSpec" {
	Properties {
		_MainTex ("Diffuse (RGB) Specular (A)", 2D) = "white" {}
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
		//#pragma target 3.0 //Uncomment this when too many parameters cause compile to fail, Shader Model 3.0+ only

    	fixed _Shininess;
    	sampler2D _MainTex;
    	fixed3 _Color;
    
    	struct Input {
			fixed2 uv_MainTex;
		};
                                                                                                   
		void surf (Input IN, inout SurfaceOutput o) {
		
		  o.Albedo = (tex2D(_MainTex, IN.uv_MainTex)).rgb * _Color.rgb * _Shininess;
		  o.Gloss = (tex2D(_MainTex, IN.uv_MainTex)).a;
          o.Specular = (tex2D(_MainTex, IN.uv_MainTex)).a;
          
		}
				
		ENDCG
	} 
	FallBack "Hotgen/Wrap/Wrap"
}
