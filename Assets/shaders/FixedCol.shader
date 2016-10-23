Shader ".ShaderTalk/Fixed Unlit" // names the shader and put it in the drop down writing in ShaderLab
{
	Properties 
	{
		_Color ("Main color", Color) = (1,1,1,1)
	
	}



	SubShader 
	{
		Pass 
		{
		CGPROGRAM //writing in cg 
		#pragma vertex vert // declares name
		#pragma fragment frag

		struct appdata 
		{
			float4 vertex : POSITION; 

		};

		struct v2f
		{
			float4 pos : SV_POSITION;
		
		};

		fixed4 _Color;


		v2f vert (appdata IN)
		{
			v2f OUT;
			OUT.pos = mul(UNITY_MATRIX_MVP, IN.vertex);

			return OUT;
		}

		fixed4 frag (v2f IN) : COLOR
		{
				//return fixed4(1,0,0,1); only returns hard coded value 
				return _Color; // returns the varible can change this in editor 
			 
		} 

		ENDCG
		}
	}

}