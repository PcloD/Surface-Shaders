Shader "Optimised/AdditiveRim/AdditiveRimUnlit" {
	Properties {
		_MainTex ("Diffuse (RGB) Transparency (A)", 2D) = "white" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
		_RimStrength ("Opacity", Range (0, 1)) = 0.5
		_RimWidth ("Opacity Falloff", Range (0, 1)) = 0.5	
		}					
   SubShader {
   		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"} 
              
      Pass {
         Cull Back
         ZWrite Off
         Blend SrcAlpha One //additive
 
         CGPROGRAM 
         #pragma vertex vert  
         #pragma fragment frag 
         #include "UnityCG.cginc"
         
         sampler2D _MainTex;
		 fixed _RimStrength;            
         fixed _RimWidth;
         fixed4 _Color;
 
//VERTEX IN
         struct vertexInput {
            fixed vertex : POSITION;
            fixed4 texcoord1 : TEXCOORD1;
            fixed3 normal : NORMAL;
         };

//VERTEX OUT   
           struct vertexOutput {
            fixed4 pos : SV_POSITION;
            fixed4 tex : TEXCOORD1;
            fixed3 normal : TEXCOORD2;
            fixed3 viewDir : TEXCOORD3;
         };
 
         vertexOutput vert(appdata_full input) 
         {
            vertexOutput output; 
 
            half4x4 modelMatrix = _Object2World;
            half4x4 modelMatrixInverse = _World2Object;
            output.normal = normalize(fixed3(mul(fixed4(input.normal, 0.0), modelMatrixInverse).rgb));
            output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
			output.viewDir = normalize(_WorldSpaceCameraPos - fixed3(mul(modelMatrix, input.vertex).rgb));
            output.tex = input.texcoord;
            output.pos =  mul(UNITY_MATRIX_MVP, input.vertex);
            
            return output;
         }

//FRAGMENT START  
         fixed4 frag(vertexOutput input) : COLOR 
         {
          	fixed3 normalDirection = normalize(input.normal);
            fixed3 viewDirection = normalize(input.viewDir);
            fixed newOpacity = min(1.0, _RimWidth / abs(dot(viewDirection, normalDirection)));
 
            return (tex2D(_MainTex, fixed2(input.tex.xy))*_Color) * saturate(fixed4(1.0, 1.0, 1.0, (newOpacity*_RimStrength)));	
         }
 
         ENDCG  
      }
   }
}