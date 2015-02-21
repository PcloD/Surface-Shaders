Shader "Optimised/RGBATexBlend/RGBATexBlendUnlit" {
	Properties {
		_RedTex ("Diffuse (Red)(RGB)", 2D) = "white" {}
		_GreenTex ("Diffuse (Green)(RGB)", 2D) = "white" {}
		_BlueTex ("Diffuse (Blue)(RGB)", 2D) = "white" {}
		_AlphaTex ("Diffuse (Alpha)(RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 100
Pass {
		CGPROGRAM
		#pragma vertex vert
        #pragma fragment frag
        #include "UnityCG.cginc"

		sampler2D _RedTex;
		sampler2D _GreenTex;
		sampler2D _BlueTex;
		sampler2D _AlphaTex;

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
		fixed4 textureColorRed = tex2D(_RedTex, fixed2(input.tex.xy));
		fixed4 textureColorGreen = tex2D(_GreenTex, fixed2(input.tex.xy));
		fixed4 textureColorBlue = tex2D(_BlueTex, fixed2(input.tex.xy));
		fixed4 textureColorAlpha = tex2D(_AlphaTex, fixed2(input.tex.xy));
 				
		return 
		 ((tex2D(_RedTex, input.tex.xy))*input.col.r)
		+((tex2D(_GreenTex, input.tex.xy))*input.col.g)
		+((tex2D(_BlueTex, input.tex.xy))*input.col.b)
		+((tex2D(_AlphaTex, input.tex.xy))*input.col.a); 
		}
		ENDCG
	}
}
}
