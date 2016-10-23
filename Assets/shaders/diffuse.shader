

Shader ".ShaderTalk/Diffuse" // names the shader and put it in the drop down writing in ShaderLab
{
	Properties 
	{
		_Color ("Main color", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {} // {} empty texture 
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
			float3 normal : NORMAL; //get in the normals 
			float2 texcoord : TEXCOORD0; //REQUEST TEXTURE CORDINATES 
		};

		struct v2f
		{
			float4 pos : SV_POSITION;
			float3 normal : NORMAL;
			float2 texcoord : TEXCOORD0;
		};

		float4 _Lightcolor0;
		fixed4 _Color;
		sampler2D _MainTex;

		v2f vert (appdata IN)
		{
			v2f OUT;
			OUT.pos = mul(UNITY_MATRIX_MVP, IN.vertex);
			OUT.normal = mul(float4(IN.normal, 0.0), unity_ObjectToWorld).xyzw; //converts from object space to world space 
			OUT.texcoord = IN.texcoord; 
			return OUT;
		}

		fixed4 frag (v2f IN) : COLOR
		{
			//return fixed4(1,0,0,1); only returns hard coded value 
			//return _Color; returns the varible can change this in editor 
		 fixed4 texColor = tex2D(_MainTex, IN.texcoord); 
			//return texColor;

			 float3 normalDirection = normalize(IN.normal); //normalize  
			 float3 lightDirection = normalize (_WorldSpaceLightPos0.xyz);
			 float3 diffuse = _Lightcolor0.rgb * max(0.0, dot(normalDirection, lightDirection));

			 return texColor * _Color * float4(diffuse, 1); 
		} 

		ENDCG
		}
	}

}