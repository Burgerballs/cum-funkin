shader_type canvas_item;

uniform vec4 key_color : source_color = vec4(0.0, 1.0, 0.0, 1.0);  // Default green for chroma key
uniform float hue_threshold : hint_range(0.0, 1.0) = 0.1;  // Threshold for hue matching (how close the hue must be)
uniform float chroma_threshold : hint_range(0.0, 1.0) = 0.3;  // Threshold for chroma (saturation) matching
uniform float feathering : hint_range(0.0, 1.0) = 0.1;  // Feathering for smooth edges

vec3 rgb_to_hsv(vec3 c) {
    float max_val = max(c.r, max(c.g, c.b));
    float min_val = min(c.r, min(c.g, c.b));
    float delta = max_val - min_val;

    // Hue calculation
    float h = 0.0;
    if (delta > 0.0) {
        if (max_val == c.r) {
            h = mod((c.g - c.b) / delta, 6.0);
        } else if (max_val == c.g) {
            h = (c.b - c.r) / delta + 2.0;
        } else {
            h = (c.r - c.g) / delta + 4.0;
        }
        h /= 6.0;
        if (h < 0.0) h += 1.0;
    }

    // Saturation calculation
    float s = (max_val == 0.0) ? 0.0 : delta / max_val;

    // Value calculation
    float v = max_val;

    return vec3(h, s, v);
}

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    // Check if the pixel is black or near-black
    if (tex_color.r < 0.01 && tex_color.g < 0.01 && tex_color.b < 0.01) {
        // Set the pixel color without any change
        COLOR = tex_color;
    } else {
        // Convert the texture color to HSV
        vec3 hsv = rgb_to_hsv(tex_color.rgb);

        // Calculate the hue difference between the texture color and the key color
        float hue_diff = abs(hsv.r - rgb_to_hsv(key_color.rgb).r);
        if (hue_diff > 0.5) hue_diff = 1.0 - hue_diff;  // Handle wraparound in hue (0 to 1)

        // Calculate the chroma difference (saturation)
        float chroma_diff = abs(hsv.g - rgb_to_hsv(key_color.rgb).g);

        // Calculate the distance from the key color in HSV space
        bool is_keyed = (hue_diff < hue_threshold && chroma_diff < chroma_threshold);

        // Feathering: Smoothly transition alpha based on the chroma threshold
        float alpha = is_keyed ? smoothstep(chroma_threshold - feathering, chroma_threshold + feathering, chroma_diff) : 1.0;

        // Set the final alpha value
        tex_color.a *= alpha;
        COLOR = tex_color;
    }
}
