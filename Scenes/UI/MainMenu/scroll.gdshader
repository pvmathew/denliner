shader_type canvas_item;

uniform float speed = 0.1;
uniform float transparency_threshold = 0.1; // Define your threshold value here

void vertex() {
    UV.x += TIME * speed;
    UV.y += TIME * speed;
}

//void fragment() {
    //vec4 color_main = texture(TEXTURE, UV);
    //COLOR = color_main;
//}
