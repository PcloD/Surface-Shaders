Shader "Optimised/Rimlight/RimlightUnlit" {
	Properties {
		_MainTex ("Diffuse (RGB)", 2D) = "white" {}
		_Color ("Main Color (RGB)", Color) = (1,1,1,1)
		_RimColor ("Rim Color (RGB)", Color) = (1,1,1,1)
		_RimStrength ("Rim Strength", Range (0, 5)) = 0.5
		_RimWidth ("Rim Width", Range (0, 5)) = 0.5
	}
	SubShader {
		Pass {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		LOD 100
		
		CGPROGRAM
        #pragma vertex vert  
        #pragma fragment frag 
        #include "UnityCG.cginc"

		 uniform fixed4 _MainTex_ST;
         uniform fixed4 _Color;
         uniform sampler2D _MainTex;
		 fixed _RimStrength;            
         fixed _RimWidth;
         fixed4 _RimColor;
         
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
            fixed3 normal : TEXCOORD2;
            fixed3 viewDir : TEXCOORD3;
         };

         vertexOutput vert(vertexInput input) 
         {
            vertexOutput output;

            half4x4 modelMatrix = _Object2World;
            half4x4 modelMatrixInverse = _World2Object;
            output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
            output.normal = normalize(fixed3(mul(fixed4(input.normal, 0.0), modelMatrixInverse).rgb));
            output.viewDir = normalize(_WorldSpaceCameraPos - fixed3(mul(modelMatrix, input.vertex).rgb));
 			output.tex = input.texcoord0;
            return output;
         }
            
//FRAGMENT START
         fixed4 frag(vertexOutput input) : COLOR
         {
           	fixed3 normalDirection = normalize(input.normal);
            fixed4 textureColor = tex2D(_MainTex, fixed2(input.tex.xy));
            fixed3 viewDirection = normalize(input.viewDir);
           	fixed Rim = min(1.0, _RimWidth / abs(dot(viewDirection, normalDirection)));
 			     
           	return fixed4(tex2D(_MainTex, _MainTex_ST.xy * input.tex.xy + _MainTex_ST.zw) + (fixed4(Rim*_RimStrength, Rim*_RimStrength, Rim*_RimStrength, 1.0)*_RimColor));     
         }

		ENDCG
	}
} 
}
