Shader "Optimised/RTexBlend/RTexBlendUnlit" {
	Properties {
		_BlackTex ("Diffuse (Black)(RGB)", 2D) = "white" {}
		_WhiteTex ("Diffuse (White)(RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 100
Pass {
		CGPROGRAM
		#pragma vertex vert
        #pragma fragment frag
        #include "UnityCG.cginc"

		sampler2D _BlackTex;
		sampler2D _WhiteTex;

//VERTEX IN
		struct vertexInput {
			fixed4 vertex : POSITION;
            fixed4 texcoord0 : TEXCOORD0;
            fixed4 color : COLOR;
		};
		
//VERTEX OUT
		struct vertexOutput {
			fixed4 pos : SV_POSITION;
			fixed4 col : COLOR;
            fixed4 tex : TEXCOORD0;
		};				

		vertexOutput vert(vertexInput input) 
         {
        vertexOutput output;
		output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
        output.col = input.color;
        output.tex = input.texcoord0;
        return output;
        }

//FRAGMENT OUT		
		fixed4 frag(vertexOutput input) : COLOR0
		{
		fixed4 textureColorBlack = tex2D(_BlackTex, fixed2(input.tex.xy));
		fixed4 textureColorWhite = tex2D(_WhiteTex, fixed2(input.tex.xy));
 				
		return lerp(textureColorBlack, textureColorWhite, input.col.r);		
		}
		ENDCG
	}
}
}

