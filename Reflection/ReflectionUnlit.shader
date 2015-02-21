Shader "Optimised/Reflection/ReflectionUnlit" {
	Properties {
		_MainTex ("Diffuse (RGB)", 2D) = "white" {}
		_Cube ("Cubemap", CUBE) = "" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
	}
	SubShader {
		Pass {  
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 300 
		
         CGPROGRAM
         #pragma vertex vert  
         #pragma fragment frag
         #include "UnityCG.cginc"
 
		sampler2D _MainTex;
        samplerCUBE _Cube;
        fixed3 _Color;

//VERTEX IN         
         struct vertexInput {
            fixed4 vertex : POSITION;
            fixed3 normal : NORMAL;
            fixed4 texcoord0 : TEXCOORD0;
         };
         
//VERTEX OUT
         struct vertexOutput {
			fixed4 pos : SV_POSITION;
			fixed4 col : COLOR;
            fixed4 tex : TEXCOORD0;
            fixed3 normalDir : TEXCOORD1;
            fixed3 viewDir : TEXCOORD2;
         };
 
         vertexOutput vert(vertexInput input) 
         {
            vertexOutput output;
 
            half4x4 modelMatrix = _Object2World;
            half4x4 modelMatrixInverse = _World2Object; 
            output.viewDir = fixed3(mul(modelMatrix, input.vertex).rgb - fixed4(_WorldSpaceCameraPos, 1.0).rgb);
            output.normalDir = normalize(fixed3(mul(fixed4(input.normal, 0.0), modelMatrixInverse).rgb));
            output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
            output.tex = input.texcoord0;
            return output;
         }
 
         fixed4 frag(vertexOutput input) : COLOR
         {
            fixed3 reflectedDir = reflect(input.viewDir, normalize(input.normalDir));
            fixed4 cubemap = texCUBE(_Cube, reflectedDir);
            return fixed4(tex2D(_MainTex, input.tex.xy) + (cubemap * 0.5));
         }
 
         ENDCG
      }
	} 
	FallBack "Hotgen/Reflection/Reflection"
}
