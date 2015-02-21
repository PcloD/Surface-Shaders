Shader "Optimised/AdditiveRim/AdditiveRimDirectional" {
	Properties {
		_MainTex ("Diffuse", 2D) = "white" {}
		_Color ("Main Color", Color) = (1,1,1,1)
		_RimStrength ("Opacity", Range (0, 1)) = 0.5
		_RimWidth ("Opacity Falloff", Range (0, 1)) = 0.5	
		}
					
   SubShader {
   		Tags {"Queue" = "Transparent" "LightMode" = "ForwardBase"} 
              
      Pass {
         Cull Back
         ZWrite Off
         Blend SrcAlpha One //blend
 
         CGPROGRAM
         #pragma vertex vert  
         #pragma fragment frag 
         #include "UnityCG.cginc"
         
         sampler2D _MainTex;
         fixed4 _LightColor0; 
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
			fixed4 col : COLOR;
         };
 
         vertexOutput vert(appdata_full input) 
         {
            vertexOutput output; 
 
            half4x4 modelMatrix = _Object2World;
            half4x4 modelMatrixInverse = _World2Object; 
            fixed3 normalDirection = normalize(fixed3(mul(fixed4(input.normal, 0.0), modelMatrixInverse).rgb));
            fixed3 lightDirection = normalize(fixed3(_WorldSpaceLightPos0.rgb));
            fixed3 diffuseReflection = fixed3(_LightColor0.rgb) * fixed3(_Color.rgb) * (max(0.0, dot(normalDirection, lightDirection)));      
            
            fixed3 cm1 = fixed3(input.normal.xy, 0.0);
            fixed3 cm2 = mul(cm1, modelMatrixInverse);
            
            output.normal = normalize(fixed3(cm2));
            output.col = fixed4(diffuseReflection, 1.0);
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
 
            return (tex2D(_MainTex, fixed2(input.tex.xy))*input.col) * saturate(fixed4(1.0, 1.0, 1.0, (newOpacity*_RimStrength)));	
         }
 
         ENDCG  
      }
   }
}