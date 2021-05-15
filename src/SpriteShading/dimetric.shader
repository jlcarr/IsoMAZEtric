shader_type spatial;

uniform float scale = 8.0;
uniform float x_val = 9.0;
uniform sampler2D sprite;

uniform vec3 pos;


void vertex(){
	// dimetric projection matrix stretch
	mat4 stretch = mat4(1.0);
	stretch[0][0] = sqrt(2.0);
	stretch[1][1] = sqrt(6.0)/2.0;
	
	PROJECTION_MATRIX = stretch*PROJECTION_MATRIX;
	
	// every step away from the center need to correct by 1 pixel for outline overlap
	float w_offset = 2.0*(pos.z - pos.x)/VIEWPORT_SIZE.x/2.0;
	float h_offset = (pos.x + pos.z - 2.0 * pos.y)/VIEWPORT_SIZE.y/2.0;
	vec4 offset = inverse(WORLD_MATRIX)*CAMERA_MATRIX*INV_PROJECTION_MATRIX*inverse(stretch)*vec4(w_offset,h_offset,0.0,0.0);
	VERTEX += offset.xyz;
}