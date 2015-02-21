Shader "Optimised/Standard/StandardUnlit" {
Properties {
	_MainTex ("Diffuse (RGB)", 2D) = "white" {}
}
SubShader {
	Tags { "Queue"="Geometry" "RenderType"="Opaque" }
	LOD 100
	
	Pass {  
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag		
			#include "UnityCG.cginc"

//VERTEX IN
			struct vertexInput {
				fixed4 vertex : POSITION;
				fixed2 texcoord : TEXCOORD0;
			};

//VERTEX OUT
			struct vertexOutput {
				fixed4 vertex : SV_POSITION;
				fixed2 texcoord : TEXCOORD0;
			};

			sampler2D _MainTex;
			fixed4 _MainTex_ST;
			
			vertexOutput vert(vertexInput input) 
         	{
            vertexOutput output;
				output.vertex = mul(UNITY_MATRIX_MVP, input.vertex);
				output.texcoord = TRANSFORM_TEX(input.texcoord, _MainTex);
				return output;
			}

//FRAGMENT START			
			float4 frag(vertexOutput input) : COLOR
			{
				return tex2D(_MainTex, input.texcoord);
			}
		ENDCG
		}
	}
}