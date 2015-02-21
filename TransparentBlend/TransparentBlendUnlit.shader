Shader "Optimised/TransparentBlend/TransparentBlendUnlit" {
	Properties {
		_MainTex ("Diffuse (RGB) Transparency (A)", 2D) = "white" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
		_Transparency ("Transparency", Range (-1, 1)) = 0.0
	}
	SubShader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		LOD 100
        
      Pass {	
         Cull Front
         ZWrite Off
         Blend SrcAlpha OneMinusSrcAlpha
 
         CGPROGRAM
         #pragma vertex vert  
         #pragma fragment frag 
 
         uniform sampler2D _MainTex;    
         uniform fixed _Transparency;
         uniform fixed4 _Color;
 
         struct vertexInput {
            fixed4 vertex : POSITION;
            fixed4 texcoord : TEXCOORD0;
         };
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
 
         float4 frag(vertexOutput input) : COLOR
         {
            return fixed4((tex2D(_MainTex, float2(input.tex.xy))).r, 
            			  (tex2D(_MainTex, float2(input.tex.xy))).g, 
            			  (tex2D(_MainTex, float2(input.tex.xy))).b,
            			  (tex2D(_MainTex, float2(input.tex.xy))).a + _Transparency)*_Color; 
         }
 
         ENDCG
      }
 
      Pass {	
         Cull Back
         ZWrite Off
         Blend SrcAlpha OneMinusSrcAlpha
 
         CGPROGRAM
         #pragma vertex vert  
         #pragma fragment frag 
 
         uniform sampler2D _MainTex;    
         uniform fixed _Transparency;
         uniform fixed4 _Color;
 
         struct vertexInput {
            fixed4 vertex : POSITION;
            fixed4 texcoord : TEXCOORD0;
         };
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
 
         float4 frag(vertexOutput input) : COLOR
         {
            return fixed4((tex2D(_MainTex, float2(input.tex.xy))).r, 
            			  (tex2D(_MainTex, float2(input.tex.xy))).g, 
            			  (tex2D(_MainTex, float2(input.tex.xy))).b,
            			  (tex2D(_MainTex, float2(input.tex.xy))).a + _Transparency)*_Color;
         }
 
         ENDCG
      }
   }
   // Fallback "Unlit/Transparent"
}


