/**
 * GameMaker Raycast Collision System
 * Component: Collision Query
 * Dependencies: collision_geometry
 * Copyright (c) 2026 Dennneh | MIT License
 */

/// A raycast against collision shapes and edges.
/// @param {Real} x The X position of the origin.
/// @param {Real} y The Y position of the origin.
/// @param {Real|Struct} dir The direction the ray should travel in (either in degrees or as a normal struct).
/// @param {Real} distance The distance the ray should travel.
/// @param {Array} ignore Instances to ignore.
function collision_raycast(x, y, dir, distance, ignore = [])
{
	// We will use a normal for out calculations
	if(is_real(dir))
		dir = { x: dcos(dir), y : -dsin(dir) };
	var x_dist = dir.x * distance;
	var y_dist = dir.y * distance;
	var x_end = x + x_dist;
	var y_end = y + y_dist;
		
	// Do AABB checks
	var candidates = [];
	var total_colliders = instance_number(obj_collider_static);
	var ray_bbox = { x1 : min(x, x_end), y1 : min(y, y_end), x2 : max(x, x_end), y2 : max(y, y_end) };
	
	for(var i = 0; i < total_colliders; i++)
	{
		// Instead of using the collision_shape_AABB_check function we include the raw code for optimization
		var inst = instance_find(obj_collider_static, i);
		if(inst.bbox_left < ray_bbox.x2 &&
        inst.bbox_right > ray_bbox.x1 &&
        inst.bbox_top < ray_bbox.y2 &&
        inst.bbox_bottom > ray_bbox.y1)
		{
			if(!array_contains(ignore, inst))
				array_push(candidates, inst);
		}
	}
	
	// Check the candidate objects
	var closest_t = 1.0;
	var hit_obj = -1;
	var hit_edge = 0;
	var hit_u = 0;
	var hit_a;
	var hit_b;
	
	for(var i = 0; i < array_length(candidates); i++)
	{
		var verts = collision_shape_get_vertices(candidates[i]);
		var edges = collision_shape_get_edges(candidates[i]);
		if(is_array(verts) && is_array(edges))
		{
			var mirror = sign(candidates[i].image_xscale) * sign(candidates[i].image_yscale);
			
			for(var e = 0; e < array_length(edges); e++)
			{
				var a = verts[edges[e].a];
				var b = verts[edges[e].b];
				
				// Check normals (optimized)
				var dx = (b.x - a.x);
			    var dy = (b.y - a.y);
				if ((dir.x * dy * mirror) + (dir.y * -dx * mirror) >= 0)
					continue;
					
				// Check for an intersection
				var denominator = (dy * x_dist) - (dx * y_dist);
				if (abs(denominator) < 0.0001) // Lines are practically parallel
					continue;

				var vx = a.x - x;
				var vy = a.y - y;

				var u = ((vx * y_dist) - (vy * x_dist)) / denominator;
			    if (u < 0 || u > 1) // Intersection is outside the line segment
					continue;

			    var t = ((vx * dy) - (vy * dx)) / denominator;
				if (t >= 0 && t < closest_t) 
			    {
					closest_t = t;
			        hit_obj = i;
			        hit_edge = e;
					hit_u = u;
					
					hit_a = a;
					hit_b = b;
			    }
			}
		}
	}
	
	// Return hit results
	if(hit_obj >= 0)
	{
		var inst = candidates[hit_obj];
		var distance_traveled = distance * closest_t;
		
		var final_dx = hit_b.x - hit_a.x;
		var final_dy = hit_b.y - hit_a.y;
		var mirror = sign(inst.image_xscale) * sign(inst.image_yscale);
		var len = sqrt(final_dx * final_dx + final_dy * final_dy);
		
		return {
			point_x : x + (dir.x * distance_traveled),
			point_y : y + (dir.y * distance_traveled),
			distance : distance_traveled,
			instance : inst,
			normal : { x : (final_dy * mirror) / len, y : (-final_dx * mirror) / len },
			edge_id : hit_edge,
			edge_fraction : hit_u
		};
	}
	
	return undefined;
}

/// A simpler more performant raycast that just returns true or false.
/// @param {Real} x The X position of the origin.
/// @param {Real} y The Y position of the origin.
/// @param {Real|Struct} dir The direction the ray should travel in (either in degrees or as a normal struct).
/// @param {Real} distance The distance the ray should travel.
/// @param {Array} ignore Instances to ignore.
function collision_raycast_check(x, y, dir, distance, ignore = [])
{
	// Largely just a copy of the raycast script
	
	// We will use a normal for out calculations
	if(is_real(dir))
		dir = { x: dcos(dir), y : -dsin(dir) };
	var x_dist = dir.x * distance;
	var y_dist = dir.y * distance;
	var x_end = x + x_dist;
	var y_end = y + y_dist;
		
	// Do AABB checks
	var candidates = [];
	var total_colliders = instance_number(obj_collider_static);
	var ray_bbox = { x1 : min(x, x_end), y1 : min(y, y_end), x2 : max(x, x_end), y2 : max(y, y_end) };
	
	for(var i = 0; i < total_colliders; i++)
	{
		// Instead of using the collision_shape_AABB_check function we include the raw code for optimization
		var inst = instance_find(obj_collider_static, i);
		if(inst.bbox_left < ray_bbox.x2 &&
        inst.bbox_right > ray_bbox.x1 &&
        inst.bbox_top < ray_bbox.y2 &&
        inst.bbox_bottom > ray_bbox.y1)
		{
			if(!array_contains(ignore, inst))
				array_push(candidates, inst);
		}
	}
	
	// Check the candidate objects
	for(var i = 0; i < array_length(candidates); i++)
	{
		var verts = collision_shape_get_vertices(candidates[i]);
		var edges = collision_shape_get_edges(candidates[i]);
		if(is_array(verts) && is_array(edges))
		{
			var mirror = sign(candidates[i].image_xscale) * sign(candidates[i].image_yscale);
			
			for(var e = 0; e < array_length(edges); e++)
			{
				var a = verts[edges[e].a];
				var b = verts[edges[e].b];
				
				// Check normals (optimized)
				var dx = (b.x - a.x);
			    var dy = (b.y - a.y);
				if ((dir.x * dy * mirror) + (dir.y * -dx * mirror) >= 0)
					continue;
					
				// Check for an intersection
				var denominator = (dy * x_dist) - (dx * y_dist);
				if (abs(denominator) < 0.0001) // Lines are practically parallel
					continue;

				var vx = a.x - x;
				var vy = a.y - y;

				var u = ((vx * y_dist) - (vy * x_dist)) / denominator;
			    if (u < 0 || u > 1) // Intersection is outside the line segment
					continue;

			    var t = ((vx * dy) - (vy * dx)) / denominator;
				if (t >= 0 && t < 1.0) 
			    {
					return true;
			    }
			}
		}
	}
	
	return false;
}
