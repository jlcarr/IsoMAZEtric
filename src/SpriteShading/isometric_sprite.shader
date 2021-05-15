shader_type spatial;
render_mode unshaded;

uniform float scale = 8.0; // screen coord to texture coords ratio
uniform float x_val = 9.0; // texture sizing parameter
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

void fragment(){
	vec2 pixel_pos = SCREEN_UV;
	
	// Compute the pixel's position
	float h_shift = x_val+1.0;
	float w_shift = 2.0*x_val+2.0;
	float w_offset = (pos.z - pos.x) * w_shift;
	float h_offset = (pos.x + pos.z - 2.0 * pos.y) * h_shift;
	vec2 screen_offset = vec2(w_offset, h_offset);
	screen_offset /= VIEWPORT_SIZE;//*41.0;
	pixel_pos += screen_offset;
	pixel_pos.x += 1.0/VIEWPORT_SIZE.x/41.0; // seems to need a little nudge?
	
	// scale it about the center
	pixel_pos = (pixel_pos-0.5)*scale + 0.5;
	
	pixel_pos.y = 1.0 - pixel_pos.y;
	vec4 texture_color = texture(sprite, pixel_pos);
	
	ALBEDO = texture_color.rgb;
	ALPHA = texture_color.a;
	ALPHA *= float( 
		(pixel_pos.x >= 0.0) 
		&& (pixel_pos.x < 1.0) 
		&& (pixel_pos.y >= 0.0) 
		&& (pixel_pos.y < 1.0) );
	
	// test alpha
	//ALBEDO = ALPHA > 0.05 ? ALBEDO : vec3(1,0,0);
	//ALPHA = 1.0;
}