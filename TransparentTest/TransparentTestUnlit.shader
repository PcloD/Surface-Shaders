Shader "Optimised/TransparentTest/TransparentTestUnlit" {
	Properties {
		_MainTex ("Diffuse (RGB) Transparency (A)", 2D) = "white" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
		_CutOff ("Alpha Cut Off", Range (0, 1)) = 0.5
	}
	SubShader {
Pass {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		LOD 100
		ZWrite Off
        AlphaTest Greater [_CutOff]
        Cull Front 
             		
         CGPROGRAM
         #pragma vertex vert  
         #pragma fragment frag 
 
         uniform sampler2D _MainTex;    
         uniform fixed _Cutoff;

//VERTEX IN
         struct vertexInput {
            fixed4 vertex : POSITION;
            fixed4 texcoord : TEXCOORD0;
         };

//VERTEX OUT         
         struct vertexOutput {
            fixed4 pos : SV_POSITION;
            fixed4 tex : TEXCOORD0;
         };
 
         vertexOutput vert(vertexInput input) 
         {
            vertexOutput output;
 
            output.tex = input.texcoord;
            output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
            return output;
         }

 //FRAGMENT START 
         fixed4 frag(vertexOutput input) : COLOR
         {
            return tex2D(_MainTex, fixed2(input.tex.xy));  
         }
 
         ENDCG
	}
	
Pass {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		LOD 100
		ZWrite Off
        AlphaTest Greater [_CutOff]
        Cull Back 
             		
         CGPROGRAM
         #pragma vertex vert  
         #pragma fragment frag 
 
         uniform sampler2D _MainTex;    
         uniform fixed _Cutoff;

//VERTEX IN
         struct vertexInput {
            fixed4 vertex : POSITION;
            fixed4 texcoord : TEXCOORD0;
         };

//VERTEX OUT         
         struct vertexOutput {
            fixed4 pos : SV_POSITION;
            fixed4 tex : TEXCOORD0;
         };
 
         vertexOutput vert(vertexInput input) 
         {
            vertexOutput output;
 
            output.tex = input.texcoord;
            output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
            return output;
         }

 //FRAGMENT START 
         fixed4 frag(vertexOutput input) : COLOR
         {
            return tex2D(_MainTex, fixed2(input.tex.xy));  
         }
 
         ENDCG
	}
	}
	
	//FallBack "Diffuse"
}
