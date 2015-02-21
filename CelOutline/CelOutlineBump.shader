Shader "Optimised/CelOutline/CelOutlineBump" {
	Properties {
		_MainTex ("Diffuse (RGB) Specular (A)", 2D) = "white" {}
		_BumpMap ("Normal Map (RGB)", 2D) = "bump" {}
		_Ramp ("Ramp (RGB)", 2D) = "white" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
		_OutlineColor ("Outline Color (RGB)", Color) = (0,0,0,1)
        _OutlineWidth ("Outline Width", Range (0, 5)) = 0
        _RimColor ("Rim Color (RGB)", Color) = (1,1,1,1)
		_RimStrength ("Rim Strength", Range (0, 5)) = 0.5
		_RimWidth ("Rim Width", Range (0, 5)) = 0.5
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 400
		
		Pass
        {
            Name "Outline"
            Cull Front
            Blend SrcAlpha OneMinusSrcAlpha
           
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex vert
            #pragma fragment frag
           
            uniform float _OutlineWidth;
            uniform float4 _OutlineColor;
             
            struct v2f
            {
                float4 pos : POSITION;
                float4 color : COLOR;
            };
           
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
                float3 norm   = mul ((float3x3)UNITY_MATRIX_IT_MV, v.normal);
                float2 offset = TransformViewToProjection(norm.xy);
                o.pos.xy += offset * _OutlineWidth;
                o.color = _OutlineColor;
                return o;
            }
           
            half4 frag(v2f i) :COLOR
            {
                return i.color;
            }
                   
            ENDCG
        }
		
		CGPROGRAM
		#pragma surface surf LambertToonMobile addshadow fullforwardshadows approxview
		#include "../MobileLighting.cginc"
		//#pragma target 3.0 //Uncomment this when too many parameters cause compile to fail, Shader Model 3.0+ only
				
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
	FallBack "Hotgen/Ramp/Ramp"
}
