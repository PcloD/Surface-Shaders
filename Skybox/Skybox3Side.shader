Shader "Optimised/Skybox/Skybox3Side" {
Properties {
	_Tint ("Tint Color", Color) = (.5, .5, .5, .5)
	_FrontTex ("Front (+Z)", 2D) = "white" {}
	_UpTex ("Up (+Y)", 2D) = "white" {}
	_DownTex ("down (-Y)", 2D) = "white" {}
}

SubShader {
	Tags { "Queue"="Background" "RenderType"="Background" }
	Cull Back ZWrite Off Fog { Mode Off }
	
	CGINCLUDE
	#include "UnityCG.cginc"

	fixed4 _Tint;
	
	struct appdata_t {
		fixed4 vertex : POSITION;
		fixed2 texcoord : TEXCOORD0;
	};
	struct v2f {
		fixed4 vertex : POSITION;
		fixed2 texcoord : TEXCOORD0;
	};
	v2f vert (appdata_t v)
	{
		v2f o;
		o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
		o.texcoord = v.texcoord;
		return o;
	}
	fixed4 skybox_frag (v2f i, sampler2D smp)
	{
		fixed4 tex = tex2D (smp, i.texcoord);
		fixed4 col;
		col.rgb = tex.rgb + _Tint.rgb - unity_ColorSpaceGrey;
		col.a = tex.a * _Tint.a;
		return col;
	}
	ENDCG
	
	Pass {
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		sampler2D _FrontTex;
		fixed4 frag (v2f i) : COLOR { return skybox_frag(i,_FrontTex); }
		ENDCG 
	}
	Pass{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		sampler2D _FrontTex;
		fixed4 frag (v2f i) : COLOR { return skybox_frag(i,_FrontTex); }
		ENDCG 
	}
	Pass{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		sampler2D _FrontTex;
		fixed4 frag (v2f i) : COLOR { return skybox_frag(i,_FrontTex); }
		ENDCG
	}
	Pass{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		sampler2D _FrontTex;
		fixed4 frag (v2f i) : COLOR { return skybox_frag(i,_FrontTex); }
		ENDCG
	}	
	Pass{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		sampler2D _UpTex;
		fixed4 frag (v2f i) : COLOR { return skybox_frag(i,_UpTex); }
		ENDCG
	}	
	Pass{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		sampler2D _DownTex;
		fixed4 frag (v2f i) : COLOR { return skybox_frag(i,_DownTex); }
		ENDCG
	}
}
}