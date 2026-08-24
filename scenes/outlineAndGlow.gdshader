shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform vec4 glow_color : source_color;
uniform float glow_power: hint_range(0.0, 8.0, 0.1) = 2.0;
uniform float glow_shift: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float glow_radius: hint_range(1.0, 10.0, 1.0) = 1.0;
uniform float progress: hint_range(0.0, 1.0) = 0.0;

void fragment() {
	float silhouette_alpha = texture(TEXTURE, UV * 0.65 + .175).a;
	vec4 color_silhouette = vec4(glow_color);
	color_silhouette.a = silhouette_alpha;
	COLOR = mix(COLOR, color_silhouette, progress * (1.0 - COLOR.a));
	vec4 glow = vec4(0.0);
	float count = 0.0;
	for (float x = -glow_radius; x <= glow_radius; x += 1.0) {
		for (float y = -glow_radius; y <= glow_radius; y += 1.0) {
			vec2 offset = vec2(x, y) * glow_shift * TEXTURE_PIXEL_SIZE;
			glow += texture(TEXTURE, UV + offset) * glow_color;
			count += 1.0;
		}
	}
	glow *= glow_power / count;
	COLOR = mix(COLOR, glow, glow.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
