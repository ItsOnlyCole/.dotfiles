#version 120

#define VERTEX_SCALE 0.5

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelViewInverse;

uniform vec3 sunPosition;
uniform vec3 moonPosition;
uniform vec3 upPosition;
uniform vec3 previousCameraPosition;

uniform float rainStrength;
uniform float sunAngle;
uniform float far;

varying vec3 lightVector;

varying vec4 texcoord;

//out float fogEnabled;

const float sunPathRotation = -40.0;


void main() {
	texcoord = gl_MultiTexCoord0;
	gl_Position		= ftransform();

	if (sunAngle < 0.5f) {
		lightVector = normalize(sunPosition);
	} else {
		lightVector = normalize(moonPosition);
	}

	//fogEnabled = float(gl_Fog.start / far < 0.65);
}
