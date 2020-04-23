#version 120

#define Shifting_Rain				//This makes the falling rain particles shift and fall on a angle

varying vec4 color;
varying vec3 fragpos;

attribute vec4 mc_midTexCoord;


varying vec4 texcoord;
varying vec4 lmcoord;
uniform vec3 sunPosition;
uniform vec3 upPosition;
uniform int worldTime;
uniform int heldItemId;
uniform int heldBlockLightValue;
uniform float rainStrength;
uniform float wetness;
uniform ivec2 eyeBrightnessSmooth;
uniform float viewWidth;
uniform float viewHeight;

uniform vec3 cameraPosition;
uniform mat4 gbufferProjection;
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferModelView;
uniform mat4 shadowProjection;
uniform mat4 shadowModelView;

uniform float frameTimeCounter;

void main() {

	/*
This code is from Chocapic13' shaders, shifting rain
*/	
#ifdef Shifting_Rain
	vec4 position = gbufferModelViewInverse * gl_ModelViewMatrix * gl_Vertex;
		vec3 worldpos = position.xyz + cameraPosition;
		bool istopv = worldpos.y > cameraPosition.y+5.0;
	if (!istopv) position.xz += vec2(2.3,1.0)+sin(frameTimeCounter)*sin(frameTimeCounter)*sin(frameTimeCounter)*vec2(2.1,0.6);
	position.xz -= (vec2(3.0,1.0)+sin(frameTimeCounter)*sin(frameTimeCounter)*sin(frameTimeCounter)*vec2(2.1,0.6))*0.25;
	gl_Position = gl_ProjectionMatrix * gbufferModelView * position;
#else
	gl_Position = ftransform();
#endif
	
	color = gl_Color;
	texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;

	lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
}