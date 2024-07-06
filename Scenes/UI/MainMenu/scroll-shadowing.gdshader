shader_type canvas_item;

uniform float speed = 0.1;
uniform float transparency_threshold = 0.1; // Define your threshold value here
uniform vec2 shadow_offset = vec2(0.02, 0.02); // Adjust to change shadow offset
uniform vec4 shadow_color = vec4(0.0, 0.0, 0.0, 0.5); // Adjust to change shadow color
uniform sampler2D background_texture; // Reference to the background texture

void vertex() {
    UV.x += TIME * speed;
    UV.y += TIME * speed;
}

void fragment() {
    vec2 uv_shadow = UV + shadow_offset;
    vec4 colored_shadow = texture(TEXTURE, uv_shadow) * shadow_color;

    // Sample the background texture at the same UV coordinates
    vec4 color_background = texture(background_texture, UV);
	
    // Check if the background texture is not fully transparent
    if (color_background.a > transparency_threshold) {
        COLOR = colored_shadow;

	} else {
	        discard; // Do not render the shadow if there's no background
	    }
}
