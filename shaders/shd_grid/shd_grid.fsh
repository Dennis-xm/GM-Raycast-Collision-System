// Copyright (c) 2026 Dennneh | MIT License

varying vec2 v_vTexcoord;
varying vec2 v_vGridcoord;
varying vec4 v_vColour;

uniform sampler2D gridTexture;

void main()
{
	vec2 gridPos = vec2(mod(v_vGridcoord.x + 1.0, 1.0), mod(v_vGridcoord.y + 1.0, 1.0));
	gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord) * texture2D(gridTexture, gridPos) * v_vColour;
}
