shader_type canvas_item;

// Noise Texture
uniform sampler2D noise_texture: repeat_enable, filter_nearest;
// Fog density
uniform float density: hint_range(0.0, 1.0) = 0.25;
// Fog speed
uniform vec2 speed = vec2(0.02, 0.01);

void fragment() {
	// Make the fog move
	vec2 uv = UV + speed * TIME;
	// Sample the noise texture
	float noise = texture(noise_texture, uv).r;
	// Convert the noise
	// Clamp it
	float fog = clamp(noise * 2.0 - 1.0, 0.0, 1.0);
	// Apply the fog effect
	COLOR.a *= fog * density;
}