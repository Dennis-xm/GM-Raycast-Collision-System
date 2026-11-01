/**
 * GameMaker Grid Drawer
 * Copyright (c) 2026 Dennneh | MIT License
 */

global.sprite_grid_init = false;
global.sprite_grid_format = undefined;
global.sprite_grid_buffer = undefined;

global.sprite_grid_tex_width = 128;
global.sprite_grid_tex_height = 128;
global.sprite_grid_tex_uniform = -1;

function scr_setup_grid_drawing()
{
	// Vertex format
	vertex_format_begin();

	vertex_format_add_position_3d();
	vertex_format_add_colour();
	vertex_format_add_texcoord();
	vertex_format_add_texcoord(); // Second grid UV

	global.sprite_grid_format = vertex_format_end();
	
	// Vertex buffer
	global.sprite_grid_buffer = vertex_create_buffer();
	
	// Sprite texture
	global.sprite_grid_tex_width = sprite_get_width(spr_solid_grid);
	global.sprite_grid_tex_height = sprite_get_height(spr_solid_grid);
	global.sprite_grid_tex_uniform = shader_get_sampler_index(shd_grid, "gridTexture");
	
	global.sprite_grid_init = true;
}

function scr_sprite_grid_create_vertex(x, y, color, alpha, u, v)
{
	vertex_position_3d(global.sprite_grid_buffer, x, y, 0);
	vertex_colour(global.sprite_grid_buffer, color, alpha);
	vertex_texcoord(global.sprite_grid_buffer, u, v);
	vertex_texcoord(global.sprite_grid_buffer, x / global.sprite_grid_tex_width, y / global.sprite_grid_tex_height);
}

function scr_draw_self_grid()
{
	scr_draw_sprite_grid_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

function scr_draw_sprite_grid(sprite, subimg, x, y)
{
	scr_draw_sprite_grid_ext(sprite, subimg, x, y, 1, 1, 0, c_white, 1);
}

function scr_draw_sprite_grid_ext(sprite, subimg, x, y, xscale, yscale, rot, color, alpha)
{
	if(!global.sprite_grid_init)
		scr_setup_grid_drawing();
		
	// Get UV coordinates
	var uv = sprite_get_uvs(sprite_index, image_index);
		
	// Get vertex positions translated
	// Position
	var left = -sprite_get_xoffset(sprite);
	var top = -sprite_get_yoffset(sprite);
	var right = sprite_get_width(sprite) + left;
	var bottom = sprite_get_height(sprite) + top;
	
	// Scaling
	left *= xscale;
	top *= yscale;
	right *= xscale;
	bottom *= yscale;
	
	// Rotation
	var c = dcos(rot);
	var s = -dsin(rot);
		
	// Create our quad
	vertex_begin(global.sprite_grid_buffer, global.sprite_grid_format);

	scr_sprite_grid_create_vertex(x + (left * c - top * s),		y + (left * s + top * c),		color, alpha, uv[0], uv[1]); // TL
	scr_sprite_grid_create_vertex(x + (right * c - top * s),	y + (right * s + top * c),		color, alpha, uv[2], uv[1]); // TR
	scr_sprite_grid_create_vertex(x + (left * c - bottom * s),	y + (left * s + bottom * c),	color, alpha, uv[0], uv[3]); // BL
	scr_sprite_grid_create_vertex(x + (left * c - bottom * s),	y + (left * s + bottom * c),	color, alpha, uv[0], uv[3]); // BL
	scr_sprite_grid_create_vertex(x + (right * c - top * s),	y + (right * s + top * c),		color, alpha, uv[2], uv[1]); // TR
	scr_sprite_grid_create_vertex(x + (right * c - bottom * s),	y + (right * s + bottom * c),	color, alpha, uv[2], uv[3]); // BR

	vertex_end(global.sprite_grid_buffer);
	
	// Draw out quad
	shader_set(shd_grid);
	texture_set_stage(global.sprite_grid_tex_uniform, sprite_get_texture(spr_solid_grid, 0));

	vertex_submit(global.sprite_grid_buffer, pr_trianglelist, sprite_get_texture(sprite_index, image_index));

	shader_reset();
}
