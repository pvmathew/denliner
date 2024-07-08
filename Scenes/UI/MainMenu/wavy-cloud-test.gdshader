shader_type canvas_item;

uniform float speed = 5.0;
uniform float block_size = 3.0; // Control the size of the blocks

void vertex() {
    vec2 uv = VERTEX.xy / 20.0; // Adjust for screen pixel size
    float wave = sin(uv.x + speed * TIME);
    
    // Quantize the wave effect to create blocky waves
    wave = floor(wave / block_size) * block_size;
    
    VERTEX.y += wave;
}
