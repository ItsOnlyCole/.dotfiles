#version 120

#define SHADOW_MAP_BIAS 0.90			//[0.80 0.90] //set this to 0.90 for better looking shadows closer to player, set this to 0.80 for better looking shadows at a distance.
#define ShadowDist_Type							//This is to change from SEUS Extended shadows to Bruce's, SEUS doesnt look as nice and has shadow bug at extreme distance. Bruce looks the best BUT has shadow acne closer to player at Sunrise/set. ON = Seus. OFF = Bruce. 
//#define TEMP_Fix_Close_ShadowAcne				//This will fix the shadow acne bug with Bruce's Extended shadows BUT will break underground lighting
//#define TEMP_UNDERGROUND_LIGHT_FIX

//#define Continuum_GI							//this is Joeys GI from older continuums, NOT WORKING

varying vec4 texcoord;
varying vec4 vPosition;
varying vec4 color;
varying vec4 lmcoord;

varying vec3 normal;
varying vec3 rawNormal;

attribute vec4 mc_Entity;

varying float materialIDs;
varying float iswater;
varying float isStainedGlass;

uniform sampler2D noisetex;
uniform float frameTimeCounter;
uniform float rainStrength;
uniform vec3 cameraPosition;

uniform int worldTime;

uniform mat4 shadowProjectionInverse;
uniform mat4 shadowProjection;
uniform mat4 shadowModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjection;


#define WAVING_VINES
#define ENTITY_VINES        106.0
#define WAVING_LEAVES
#define WAVING_GRASS

#define WAVING_VINES_SPEED 1.0  	//[0.25 0.5 0.75 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0 6.5 7.0 7.5 8.0 8.5 9.0 9.5 10.0 11.0 12.0 13.0 14.0 15.0 16.0 17.0] //Lower numbers means faster, Higher numbers means slower
#define GRASS_SPEED		1.0		//[1.0 100.0 500.0 1000.0 5000.0]Default is 1.0, Higher numbers means slower
#define GRASS_MOVEMENT  0.85 //[0.00000085 0.000085 0.0085 0.55 0.65 0.85 0.95 1.0]Default is 0.85, Lower nimbers means slower
#define WAVING_LEAVES_SPEED 1.0		//[0.75 1.0 1.25 1.50 1.75 2.0 2.25 2.50 2.75 3.0 3.25 3.50 3.75 4.0 4.25 4.50 4.75 5.0 5.25 5.50 5.75 6.0 6.25 6.50 6.75 7.0 8.0 9.0 10.0 11.0 15.0 20.0 30.0 50.0]


vec4 cubic(float x)
{
    float x2 = x * x;
    float x3 = x2 * x;
    vec4 w;
    w.x =   -x3 + 3*x2 - 3*x + 1;
    w.y =  3*x3 - 6*x2       + 4;
    w.z = -3*x3 + 3*x2 + 3*x + 1;
    w.w =  x3;
    return w / 6.f;
}

vec4 BicubicTexture(in sampler2D tex, in vec2 coord)
{
	int resolution = 64;

	coord *= resolution;

	float fx = fract(coord.x);
    float fy = fract(coord.y);
    coord.x -= fx;
    coord.y -= fy;

    vec4 xcubic = cubic(fx);
    vec4 ycubic = cubic(fy);

    vec4 c = vec4(coord.x - 0.5, coord.x + 1.5, coord.y - 0.5, coord.y + 1.5);
    vec4 s = vec4(xcubic.x + xcubic.y, xcubic.z + xcubic.w, ycubic.x + ycubic.y, ycubic.z + ycubic.w);
    vec4 offset = c + vec4(xcubic.y, xcubic.w, ycubic.y, ycubic.w) / s;

    vec4 sample0 = texture2D(tex, vec2(offset.x, offset.z) / resolution);
    vec4 sample1 = texture2D(tex, vec2(offset.y, offset.z) / resolution);
    vec4 sample2 = texture2D(tex, vec2(offset.x, offset.w) / resolution);
    vec4 sample3 = texture2D(tex, vec2(offset.y, offset.w) / resolution);

    float sx = s.x / (s.x + s.y);
    float sy = s.z / (s.z + s.w);

    return mix( mix(sample3, sample2, sx), mix(sample1, sample0, sx), sy);
}


vec4 TextureSmooth(in sampler2D tex, in vec2 coord)
{
	int resolution = 64;

	coord *= resolution;
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	     f = f * f * (3.0f - 2.0f * f);

	coord = (i + f) / resolution;

	vec4 result = texture2D(tex, coord);

	return result;
}

float pow8(in float x) {
	x *= x;
	x *= x;
	return x * x;
}

float root8(in float x) {
	return sqrt(sqrt(sqrt(x)));
}

float length8(in vec2 x) {
	return root8(pow8(x.x) + pow8(x.y));
}


void main() {
	gl_Position = ftransform();

	lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
	texcoord = gl_MultiTexCoord0;

	vec4 position = gl_Position;

		 //position *= position.w;

		 position = shadowProjectionInverse * position;
		 position = shadowModelViewInverse * position;
		 position.xyz += cameraPosition.xyz;
		 //position = gbufferModelView * position;


	//convert to world-space position

	materialIDs = 0.0f;


	iswater = 0.0;

	if (mc_Entity.x == 1971.0f)
	{
		iswater = 1.0f;
	}

	if (mc_Entity.x == 8 || mc_Entity.x == 9) {
		iswater = 1.0f;
	}

	float isice = 0.0f;


	
	if (mc_Entity.x == 79) {
		isice = 1.0f;
	}

	isStainedGlass = 0.0f;

	if (mc_Entity.x == 95 || mc_Entity.x == 160)
	{
		isStainedGlass = 1.0f;
	}


	//Grass
	if  (  mc_Entity.x == 31.0

		|| mc_Entity.x == 38.0f 	//Rose
		|| mc_Entity.x == 37.0f 	//Flower
		|| mc_Entity.x == 1925.0f 	//Biomes O Plenty: Medium Grass
		|| mc_Entity.x == 1920.0f 	//Biomes O Plenty: Thorns, barley
		|| mc_Entity.x == 1921.0f 	//Biomes O Plenty: Sunflower
		|| mc_Entity.x == 188.0f 	//Biomes O Plenty: Medium Grass
		|| mc_Entity.x == 176.0f 	//Biomes O Plenty: Desert Grass
		|| mc_Entity.x == 177.0f 	//Biomes O Plenty: Desert Grass
		|| mc_Entity.x == 178.0f 	//Lavender

		)
	{
			materialIDs = max(materialIDs, 2.0f);
	}

	//Wheat
	if (mc_Entity.x == 59.0) {
		materialIDs = max(materialIDs, 2.0f);
	}	
	
	//Leaves
	if   ( mc_Entity.x == 18.0 

		|| mc_Entity.x == 161.0f
		|| mc_Entity.x == 1962.0f //Biomes O Plenty: Leaves
		|| mc_Entity.x == 1924.0f //Biomes O Plenty: Leaves
		|| mc_Entity.x == 1923.0f //Biomes O Plenty: Leaves
		|| mc_Entity.x == 1926.0f //Biomes O Plenty: Leaves
		|| mc_Entity.x == 1936.0f //Biomes O Plenty: Giant Flower Leaves
		|| mc_Entity.x == 184.0f  //Yellow autumn leaves
		|| mc_Entity.x == 185.0f  //Dying leaves
		|| mc_Entity.x == 186.0f  //maple leaves
		|| mc_Entity.x == 187.0f  //maple leaves
		|| mc_Entity.x == 192.0f  //maple leaves
		|| mc_Entity.x == 249.0f  //Willow leaves
		|| mc_Entity.x == 248.0f  //Sacred Oak Leaves

		 ) {
		materialIDs = max(materialIDs, 3.0f);
	}
		
	//Ice
	if (  mc_Entity.x == 79.0f
	   || mc_Entity.x == 174.0f)
	{
		materialIDs = max(materialIDs, 4.0f);
	}

	//Cobweb
	if ( mc_Entity.x == 30.0f)
	{
		materialIDs = max(materialIDs, 11.0f);
	}

	float grassWeight = mod(texcoord.t * 16.0f, 1.0f / 16.0f);

	float lightWeight = clamp((lmcoord.t * 33.05f / 32.0f) - 1.05f / 32.0f, 0.0f, 1.0f);
		  lightWeight *= 1.1f;
		  lightWeight -= 0.1f;
		  lightWeight = max(0.0f, lightWeight);
		  lightWeight = pow(lightWeight, 5.0f); 

		  if (grassWeight < 0.01f) {
		  	grassWeight = 1.0f;
		  } else {
		  	grassWeight = 0.0f;
		  }

	//Waving grass
	//Waving grass
	if (materialIDs == 2.0f)
	{
		vec2 angleLight = vec2(0.0f);
		vec2 angleHeavy = vec2(0.0f);
		vec2 angle 		= vec2(0.0f);

		vec3 pn0 = position.xyz;
			 pn0.x -= frameTimeCounter / 3.0f;

		vec3 stoch = BicubicTexture(noisetex, pn0.xz / 64.0f).xyz;
		vec3 stochLarge = BicubicTexture(noisetex, position.xz / (64.0f * 6.0f)).xyz;

		vec3 pn = position.xyz;
			 pn.x *= 2.0f;
			 pn.x -= frameTimeCounter * 15.0f;
			 pn.z *= 8.0f;

		vec3 stochLargeMoving = BicubicTexture(noisetex, pn.xz / (64.0f * 10.0f)).xyz;



		vec3 p = position.xyz;
		 	 p.x += sin(p.z / 2.0f) * 1.0f;
		 	 p.xz += stochLarge.rg * 5.0f;

		float windStrength = mix(0.85f, 1.0f, rainStrength);
		float windStrengthRandom = stochLargeMoving.x;
			  windStrengthRandom = pow(windStrengthRandom, mix(2.0f, 1.0f, rainStrength));
			  windStrength *= mix(windStrengthRandom, 0.5f, rainStrength * 0.25f);
			  //windStrength = 1.0f;

		//heavy wind
		float heavyAxialFrequency 			= 8.0f;
		float heavyAxialWaveLocalization 	= 0.9f;
		float heavyAxialRandomization 		= 13.0f;
		float heavyAxialAmplitude 			= 15.0f;
		float heavyAxialOffset 				= 15.0f;

		float heavyLateralFrequency 		= 6.732f;
		float heavyLateralWaveLocalization 	= 1.274f;
		float heavyLateralRandomization 	= 1.0f;
		float heavyLateralAmplitude 		= 6.0f;
		float heavyLateralOffset 			= 0.0f;

		//light wind
		float lightAxialFrequency 			= 5.5f;
		float lightAxialWaveLocalization 	= 1.1f;
		float lightAxialRandomization 		= 21.0f;
		float lightAxialAmplitude 			= 5.0f;
		float lightAxialOffset 				= 5.0f;

		float lightLateralFrequency 		= 5.9732f;
		float lightLateralWaveLocalization 	= 1.174f;
		float lightLateralRandomization 	= 0.0f;
		float lightLateralAmplitude 		= 1.0f;
		float lightLateralOffset 			= 0.0f;

		float windStrengthCrossfade = clamp(windStrength * 2.0f - 1.0f, 0.0f, 1.0f);
		float lightWindFade = clamp(windStrength * 2.0f, 0.2f, 1.0f);

		angleLight.x += sin(frameTimeCounter * lightAxialFrequency 		- p.x * lightAxialWaveLocalization		+ stoch.x * lightAxialRandomization) 	* lightAxialAmplitude 		+ lightAxialOffset;	
		angleLight.y += sin(frameTimeCounter * lightLateralFrequency 	- p.x * lightLateralWaveLocalization 	+ stoch.x * lightLateralRandomization) 	* lightLateralAmplitude  	+ lightLateralOffset;

		angleHeavy.x += sin(frameTimeCounter * heavyAxialFrequency 		- p.x * heavyAxialWaveLocalization		+ stoch.x * heavyAxialRandomization) 	* heavyAxialAmplitude 		+ heavyAxialOffset;	
		angleHeavy.y += sin(frameTimeCounter * heavyLateralFrequency 	- p.x * heavyLateralWaveLocalization 	+ stoch.x * heavyLateralRandomization) 	* heavyLateralAmplitude  	+ heavyLateralOffset;

		angle = mix(angleLight * lightWindFade, angleHeavy, vec2(windStrengthCrossfade));
		angle *= 2.0f;

		// //Rotate block pivoting from bottom based on angle
		position.x += (sin((angle.x / 180.0f) * 3.141579f)) * grassWeight * lightWeight						* 1.0f	;
		position.z += (sin((angle.y / 180.0f) * 3.141579f)) * grassWeight * lightWeight						* 1.0f	;
		position.y += (cos(((angle.x + angle.y) / 180.0f) * 3.141579f) - 1.0f)  * grassWeight * lightWeight	* 1.0f	;
	}


	const float pi = 3.14159265;

	if (materialIDs == 3.0f && texcoord.t < 1.90 && texcoord.t > -1.0) {
		float speed = 0.05;


			  //lightWeight = max(0.0f, 1.0f - (lightWeight * 5.0f));
		
		float magnitude = (sin((position.y + position.x + frameTimeCounter * pi / ((28.0) * speed))) * 0.15 + 0.15) * 0.30 * lightWeight;
			  // magnitude *= grassWeight;
			  magnitude *= lightWeight;
		float d0 = sin(frameTimeCounter * pi / (112.0 * speed)) * 3.0 - 1.5;
		float d1 = sin(frameTimeCounter * pi / (142.0 * speed)) * 3.0 - 1.5;
		float d2 = sin(frameTimeCounter * pi / (132.0 * speed)) * 3.0 - 1.5;
		float d3 = sin(frameTimeCounter * pi / (122.0 * speed)) * 3.0 - 1.5;
		position.x += sin((frameTimeCounter * pi / (18.0 * speed)) + (-position.x + d0)*1.6 + (position.z + d1)*1.6) * magnitude * (1.0f + rainStrength * 1.0f);
		position.z += sin((frameTimeCounter * pi / (17.0 * speed)) + (position.z + d2)*1.6 + (-position.x + d3)*1.6) * magnitude * (1.0f + rainStrength * 1.0f);
		position.y += sin((frameTimeCounter * pi / (11.0 * speed)) + (position.z + d2) + (position.x + d3)) * (magnitude/2.0) * (1.0f + rainStrength * 1.0f);
		
	}
	
	//lower leaf movement
	if (materialIDs == 3.0f) {
		float speed = 0.075;


		
		float magnitude = (sin((frameTimeCounter * pi / ((28.0) * speed))) * 0.05 + 0.15) * 0.075 * lightWeight;
			  // magnitude *= 1.0f - grassWeight;
			  magnitude *= lightWeight;
		float d0 = sin(frameTimeCounter * pi / (122.0 * speed)) * 3.0 - 1.5;
		float d1 = sin(frameTimeCounter * pi / (142.0 * speed)) * 3.0 - 1.5;
		float d2 = sin(frameTimeCounter * pi / (162.0 * speed)) * 3.0 - 1.5;
		float d3 = sin(frameTimeCounter * pi / (112.0 * speed)) * 3.0 - 1.5;
		position.x += sin((frameTimeCounter * pi / (13.0 * speed)) + (position.x + d0)*0.9 + (position.z + d1)*0.9) * magnitude;
		position.z += sin((frameTimeCounter * pi / (16.0 * speed)) + (position.z + d2)*0.9 + (position.x + d3)*0.9) * magnitude;
		position.y += sin((frameTimeCounter * pi / (15.0 * speed)) + (position.z + d2) + (position.x + d3)) * (magnitude/1.0);
	}

#ifdef WAVING_VINES
    //large scale movement
    if ( mc_Entity.x == ENTITY_VINES ) {
        float speed = WAVING_VINES_SPEED;
        float magnitude = (sin(((position.y + position.x)/2.0 + worldTime * 3.14159265358979323846264 / ((88.0)))) * 0.05 + 0.15) * 0.26;
        float d0 = sin(worldTime * 3.14159265358979323846264 / (122.0 * speed)) * 3.0 - 1.5;
        float d1 = sin(worldTime * 3.14159265358979323846264 / (152.0 * speed)) * 3.0 - 1.5;
        float d2 = sin(worldTime * 3.14159265358979323846264 / (192.0 * speed)) * 3.0 - 1.5;
        float d3 = sin(worldTime * 3.14159265358979323846264 / (142.0 * speed)) * 3.0 - 1.5;
        position.x += sin((worldTime * 3.14159265358979323846264 / (16.0 * speed)) + (position.x + d0)*0.5 + (position.z + d1)*0.5 + (position.y)) * magnitude;
        //position.x -= 0.05;
        position.z += sin((worldTime * 3.14159265358979323846264 / (18.0 * speed)) + (position.z + d2)*0.5 + (position.x + d3)*0.5 + (position.y)) * magnitude;
        //position.z -= 0.05;
        //position.y += sin((worldTime * 3.14159265358979323846264 / (10.0 * speed)) + (position.z + d2) + (position.x + d3)) * (magnitude/2.0);
    }

    //small scale movement
    if (mc_Entity.x == 106.0 && texcoord.t < 0.20) {
        float speed = WAVING_VINES_SPEED;
        float magnitude = (sin(((position.y + position.x)/8.0 + worldTime * 3.14159265358979323846264 / ((88.0)))) * 0.15 + 0.05) * 0.22;
        float d0 = sin(worldTime * 3.14159265358979323846264 / (112.0 * speed)) * 3.0 + 0.5;
        float d1 = sin(worldTime * 3.14159265358979323846264 / (142.0 * speed)) * 3.0 + 0.5;
        float d2 = sin(worldTime * 3.14159265358979323846264 / (112.0 * speed)) * 3.0 + 0.5;
        float d3 = sin(worldTime * 3.14159265358979323846264 / (142.0 * speed)) * 3.0 + 0.5;
        position.x += sin((worldTime * 3.14159265358979323846264 / (18.0 * speed)) + (-position.x + d0)*1.6 + (position.z + d1)*1.6) * magnitude;
        //position.x -= 0.05;
        position.z += sin((worldTime * 3.14159265358979323846264 / (18.0 * speed)) + (position.z + d2)*1.6 + (-position.x + d3)*1.6) * magnitude;
        //position.z -= 0.05;
        position.y += sin((worldTime * 3.14159265358979323846264 / (11.0 * speed)) + (position.z + d2) + (position.x + d3)) * (magnitude/4.0);
    }
#endif


	if (iswater > 0.5 || isice > 0.5)
	{
		position.xyz += 10000.0;
	}


	//position = gbufferModelViewInverse * position;
	position.xyz -= cameraPosition.xyz;
	position = shadowModelView * position;
	position = shadowProjection * position;

	normal = normalize(gl_NormalMatrix * gl_Normal);
	vec3 worldNormal = gl_Normal;

	color = gl_Color;

	if (materialIDs != 2.0)
	{
		if (worldNormal.x > 0.85)
		{
			color.rgb *= 1.0 / 0.6;
		}
		if (worldNormal.x < -0.85)
		{
			color.rgb *= 1.0 / 0.6;
		}
		if (worldNormal.z > 0.85)
		{
			color.rgb *= 1.0 / 0.8;
		}
		if (worldNormal.z < -0.85)
		{
			color.rgb *= 1.0 / 0.8;
		}
		if (worldNormal.y < -0.85)
		{
			color.rgb *= 1.0 / 0.5;
		}
	}
#ifdef TEMP_Fix_Close_ShadowAcne
	#ifdef TEMP_UNDERGROUND_LIGHT_FIX
	
	#else
	
	float facingLightFactor = dot(normal, vec3(0.0, 0.0, 1.0));
	position.z += pow(max(0.0, 1.0 - facingLightFactor), 4.0) * 0.01;
	
	#endif
#endif

	gl_Position = position;

	#ifdef ShadowDist_Type
	float dist = sqrt(gl_Position.x * gl_Position.x + gl_Position.y * gl_Position.y);
	#else
	float dist = length8(gl_Position.xy * 1.165);
	#endif
	float distortFactor = (1.0f - SHADOW_MAP_BIAS) + dist * SHADOW_MAP_BIAS + 0.0;
	
	#ifdef Continuum_GI
		gl_Position.xy *= 1.0f / distortFactor;
		gl_Position.z /= 4.0;
	#else
		gl_Position.xy *= 0.95f / distortFactor;
		gl_Position.z = mix(gl_Position.z, 0.5, 0.8);
	#endif
	
	vPosition = gl_Position;

	gl_FrontColor = gl_Color;


	
}
