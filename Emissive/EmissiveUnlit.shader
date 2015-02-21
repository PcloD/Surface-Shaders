Shader "Optimised/Emissive/EmissiveUnlit" {
	Properties {
		_MainTex ("Diffuse (RGB)", 2D) = "white" {}
		_Emission ("Emission (RGB)", 2D) = "Black" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 200
		
	Pass {  
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag		
			#include "UnityCG.cginc"

//VERTEX IN
			struct appdata_t {
				fixed4 vertex : POSITION;
				fixed2 texcoord : TEXCOORD0;
			};

//VERTEX OUT
			struct v2f {
				fixed4 vertex : SV_POSITION;
				fixed2 texcoord : TEXCOORD0;
			};

			sampler2D _MainTex;
			sampler2D _Emission;
			fixed4 _Color;
			fixed4 _MainTex_ST;
			
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

//FRAGMENT START			
			fixed4 frag (v2f i) : COLOR
			{
				return (tex2D(_MainTex, i.texcoord)*_Color) + (tex2D(_Emission, i.texcoord));
			}
		ENDCG
	}
	} 
	//FallBack "Diffuse"
}
