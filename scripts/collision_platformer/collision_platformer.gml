/**
 * GameMaker Raycast Collision System
 * Component: Collision Platformer
 * Dependencies: collision_geometry, collision_query, collision_utils, collision_debug
 * Copyright (c) 2026 Dennneh | MIT License
 */

enum layout_ray_group
{
	feet,
	left,
	right,
	head,
	
	dynamic, // Dynamically switches behaviour between feet, the sides, and head
	other
}

enum layout_ray_type
{
	push,
	stick
}

/// Returns a struct used as a collision body (the thing that collides with the ground).
function collision_platformer_create_body_empty()
{
	return {
		active : true,
		right : { x : 1, y : 0 },
		can_rotate : false,
		
		layouts : {},
		cur_layout : 0,
		attachment_ray : 3,
		stick : false
	};
}

/// Returns a struct used as a collision body, preloaded with a "default" layout based on the objects mask.
function collision_platformer_create_body()
{
	var body = collision_platformer_create_body_empty();
	body.cur_layout = "default";
	body.layouts[$ "default"] = collision_platformer_generate_layout(mask_index);
	
	return body;
}

/// Generates a simple ray layout based on the given sprite mask.
function collision_platformer_generate_layout(mask)
{
	// Get the needed information from the mask
	var b_left   = sprite_get_bbox_left(mask);
	var b_right  = sprite_get_bbox_right(mask);
	var b_top    = sprite_get_bbox_top(mask);
	var b_bottom = sprite_get_bbox_bottom(mask);

	var x_offset = sprite_get_xoffset(mask);
	var y_offset = sprite_get_yoffset(mask);

	var bbox_width  = (b_right - b_left) + 1;
	var bbox_height = (b_bottom - b_top) + 1;

	var bbox_center_x = ((b_left + b_right) / 2) - x_offset;
	var bbox_center_y = ((b_top + b_bottom) / 2) - y_offset;
	
	// Create the layout
	return [
		{ x_offset : bbox_center_x, y_offset : bbox_center_y + 2, direction : { x: 0, y : -1 }, distance : bbox_height / 2 + 2, group : layout_ray_group.head },
		{ x_offset : bbox_center_x + 2, y_offset : bbox_center_y, direction : { x: -1, y : 0 }, distance : bbox_width / 2 + 2, group : layout_ray_group.left },
		{ x_offset : bbox_center_x - 2, y_offset : bbox_center_y, direction : { x: 1, y : 0 }, distance : bbox_width / 2 + 2, group : layout_ray_group.right },
		{ x_offset : bbox_center_x, y_offset : bbox_center_y - 2, direction : { x: 0, y : 1 }, distance : bbox_height / 2 + 2, group : layout_ray_group.feet },
		{ x_offset : bbox_center_x, y_offset : bbox_center_y + bbox_height / 2, direction : { x: 0, y : 1 }, distance : 16, group : layout_ray_group.feet, type : layout_ray_type.stick, target : 3 }
	];
}

/// Tests a collision at the given position.
function collision_platformer_test_collision(x, y, hsp, vsp, layout, orientation = 0, attachment = -1, stick = false, ignore = [], debug_visualize = false)
{
	var attachment_result = undefined;
	var col = false;
	
	grounded = false;
	
	for(var i = 0; i < array_length(layout); i++)
	{
		var ray = layout[i];
		
		if(variable_struct_exists(ray, "type") && ray.type == layout_ray_type.stick && !stick)
			continue;
		
		var offset = collision_utils_local_to_world({ x : ray.x_offset, y : ray.y_offset }, orientation);
		var dir = collision_utils_local_to_world(ray.direction, orientation);
		var hit = collision_raycast(x + offset.x, y + offset.y, dir, ray.distance, ignore);
		if(hit != undefined)
		{
			col = true;
			
			var pos = collision_utils_world_to_local({ x : x, y : y }, dir);
			var vel = collision_utils_world_to_local({ x : hsp, y : vsp }, dir);
			
			if(variable_struct_exists(ray, "type") && ray.type == layout_ray_type.stick)
			{
				pos.x += hit.distance;
			}
			else
			{
				pos.x -= ray.distance - hit.distance;
			}
			vel.x = min(vel.x, 0);
			
			if(ray.group == layout_ray_group.feet && vel.x >= 0)
				grounded = true;
			
			pos = collision_utils_local_to_world(pos, dir);
			vel = collision_utils_local_to_world(vel, dir);
			
			x = pos.x;
			y = pos.y;
			
			hsp = vel.x;
			vsp = vel.y;
		}
		
		if(i == attachment || (hit != undefined && variable_struct_exists(ray, "target") && i == ray.target))
			attachment_result = hit;
		
		if(debug_visualize)
		{
			if(hit != undefined)
				collision_debug_draw_ray(x + offset.x, y + offset.y, dir, ray.distance, c_red);
			else
			{
				if(variable_struct_exists(ray, "type") && ray.type == layout_ray_type.stick)
					collision_debug_draw_ray(x + offset.x, y + offset.y, dir, ray.distance, c_blue);
				else
					collision_debug_draw_ray(x + offset.x, y + offset.y, dir, ray.distance, c_lime);
			}
		}
	}
	
	return {
		collision : col,
		x : x,
		y : y,
		hsp : hsp,
		vsp : vsp,
		attachment : attachment_result
	};
}

function collision_platformer_collide(body, ignore = [], debug_visualize = false)
{
	var layout = body.layouts[$ body.cur_layout];
	var units_per_check = 10;
	var max_checks = 1;
	
	var attachment = undefined;
	var check_count = clamp(ceil(sqrt(hsp * hsp + vsp * vsp) / 10), 1, max_checks);
	var x_check = (hsp / check_count);
	var y_check = (vsp / check_count);
	
	for(var i = 0; i < check_count; i++)
	{
		var res = collision_platformer_test_collision(x + x_check, y + y_check, hsp, vsp, layout, body.right, body.attachment_ray, body.stick, ignore, debug_visualize);
		
		x = res.x;
		y = res.y;
		hsp = res.hsp;
		vsp = res.vsp;
		
		if(i == check_count - 1) // Last check
			attachment = res.attachment;
	}
	
	return attachment;
}

function collision_platformer_rotate_body(body, right, pivot_x, pivot_y)
{
	var dif = collision_utils_subtract_normal_rotation(right, body.right);
	var off = collision_utils_local_to_world({ x : x - pivot_x, y : y - pivot_y }, dif);
	
	x = pivot_x + off.x;
	y = pivot_y + off.y;
	body.right = collision_utils_normalize(right); // Just to be extra safe
	
	return body;
}

/// Visualizes a body layouts rays.
function collision_debug_visualize_body_layout(layout, x, y, orientation = { x : 1, y : 0 })
{
	for(var i = 0; i < array_length(layout); i++)
	{
		var ray = layout[i];
		var offset = collision_utils_local_to_world({ x : ray.x_offset, y : ray.y_offset }, orientation);
		collision_debug_draw_ray(x + offset.x, y + offset.y, collision_utils_local_to_world(ray.direction, orientation), ray.distance, c_olive);
	}
}
