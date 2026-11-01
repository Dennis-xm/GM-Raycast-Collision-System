/**
 * GameMaker Raycast Collision System
 * Component: Collision Debug
 * Dependencies: collision_geometry, collision_query, collision_utils
 * Copyright (c) 2026 Dennneh | MIT License
 */

/// Draws the objects collision shape for your viewing pleasures.
function collision_debug_visualize_shape(object)
{
	var verts = collision_shape_get_vertices(object);
	var edges = collision_shape_get_edges(object);
	var mirrored = collision_utils_get_mirrored(object);
	if(is_array(verts) && is_array(edges))
	{
		// Draw each collision edge
		for(var i = 0; i < array_length(edges); i++)
		{
			var edge = edges[i];
			var a = verts[edge.a];
			var b = verts[edge.b];
			
			// Draw normal (make this optional later)
			var norm = collision_utils_get_normal(a, b, mirrored);
			draw_set_color(c_aqua);
			draw_line((a.x + b.x) / 2, (a.y + b.y) / 2, (a.x + b.x) / 2 + norm.x * 4, (a.y + b.y) / 2 + norm.y * 4);
			
			// Draw the edge
			draw_set_color(c_white);
			draw_line(a.x, a.y, b.x, b.y);
			
			// Draw the vertices (make optional)
			draw_circle(a.x, a.y, 2, false);
			draw_circle(b.x, b.y, 2, false);
		}
	}
	else
	{
		// Couldn't find the necessary collision shape data
		draw_set_color(c_red);
		draw_text(object.x, object.y, "N/A")
	}
	
	draw_set_color(c_white); // Reset color
}

/// Draws a ray for that frame with the given values.
function collision_debug_draw_temp_ray(x, y, dir, distance, color)
{
	if(is_real(dir))
		dir = { x: dcos(dir), y : -dsin(dir) };
	var x_end = x + dir.x * distance;
	var y_end = y + dir.y * distance;
	
	draw_set_color(color);
	
	draw_line(x, y, x_end, y_end);
	
	draw_set_color(c_white);
}

/// Draws a ray for that frame with the given values with a collision check built in to automatically visualize any potential collisions (but is more expensive).
function collision_debug_draw_temp_ray_advanced(x, y, dir, distance, ignore = [], miss_color = c_lime, hit_color = c_red)
{
	if(collision_raycast_check(x, y, dir, distance, ignore))
		collision_debug_draw_ray(x, y, dir, distance, hit_color);
	else
		collision_debug_draw_ray(x, y, dir, distance, miss_color);
}

/// Queues to draw a ray with the given values for a set amount of time. Does not draw the ray if not possible.
function collision_debug_draw_ray(x, y, dir, distance, color, duration = 0)
{
	if(instance_exists(obj_raycast_debug_view))
		ds_list_add(obj_raycast_debug_view.queue, { x : x, y : y, direction : dir, distance : distance, color : color, duration : duration });
}

/// Draws a message at the given position that will persist for the given duration (requiring "obj_text_debug_view").
function debug_draw_text(x, y, message, color, duration = 0)
{
	if(instance_exists(obj_text_debug_view))
		ds_list_add(obj_text_debug_view.queue, { x : x, y : y, message : message, color : color, duration : duration });
}
