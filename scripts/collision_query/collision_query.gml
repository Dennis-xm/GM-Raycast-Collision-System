/**
 * GameMaker Raycast Collision System
 * Component: Collision Query
 * Dependencies: collision_geometry
 * Copyright (c) 2026 Dennneh | MIT License
 */

/// A raycast against collision shapes and edges.
/// @param {Real} x The X position of the origin.
/// @param {Real} y The Y position of the origin.
/// @param {Real|Struct} dir The direction the ray should travel in (either in degrees or as a normalized Vector2).
/// @param {Real} distance The distance the ray should travel.
/// @param {Array} ignore Instances to ignore.
function collision_raycast(x, y, dir, distance, ignore = [])
{
	// We will use a normal for out calculations
	if(is_real(dir))
		dir = new Vector2(dcos(dir), -dsin(dir));
	
	var dist = dir.clone().multiply(distance);
	var start_pos = new Vector2(x, y);
	var end_pos = start_pos.clone().add(dist);
		
	// Do AABB checks
	var candidates = [];
	var total_colliders = instance_number(obj_collider_static);
	var ray_bbox = { x1 : min(start_pos.x, end_pos.x), y1 : min(start_pos.y, end_pos.y), x2 : max(start_pos.x, end_pos.x), y2 : max(start_pos.y, end_pos.y) };
	
	for(var i = 0; i < total_colliders; i++)
	{
		// Instead of using the collision_shape_AABB_check function we include the raw code for optimization
		var inst = instance_find(obj_collider_static, i);
		if(inst.bbox_left <= ray_bbox.x2 &&
        inst.bbox_right >= ray_bbox.x1 &&
        inst.bbox_top <= ray_bbox.y2 &&
        inst.bbox_bottom >= ray_bbox.y1)
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
				var d = b.clone().subtract(a);
				if ((dir.x * d.y * mirror) + (dir.y * -d.x * mirror) >= 0)
					continue;
					
				// Check for an intersection
				var denominator = (d.y * dist.x) - (d.x * dist.y);
				if (abs(denominator) < 0.0001) // Lines are practically parallel
					continue;

				var v = a.clone().subtract(start_pos);

				var u = ((v.x * dist.y) - (v.y * dist.x)) / denominator;
			    if (u < 0 || u > 1) // Intersection is outside the line segment
					continue;

			    var t = ((v.x * d.y) - (v.y * d.x)) / denominator;
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
		
		var final_d = hit_b.clone().subtract(hit_a);
		var mirror = sign(inst.image_xscale) * sign(inst.image_yscale);
		var len = sqrt(final_d.x * final_d.x + final_d.y * final_d.y);
		
		var result = new RaycastResult();
		result.point = dir.clone().multiply(distance_traveled).add(start_pos);
		result.distance = distance_traveled;
		result.instance = inst;
		result.normal = new Vector2((final_d.y * mirror) / len, (-final_d.x * mirror) / len);
		result.edge_id = hit_edge;
		result.edge_fraction = hit_u;
		
		return result;
	}
	
	return undefined;
}

/// A simpler more performant raycast that just returns true or false.
/// @param {Real} x The X position of the origin.
/// @param {Real} y The Y position of the origin.
/// @param {Real|Struct} dir The direction the ray should travel in (either in degrees or as a normalized Vector2).
/// @param {Real} distance The distance the ray should travel.
/// @param {Array} ignore Instances to ignore.
function collision_raycast_check(x, y, dir, distance, ignore = [])
{
	// Largely just a copy of the raycast script
	
	// We will use a normal for out calculations
	if(is_real(dir))
		dir = new Vector2(dcos(dir), -dsin(dir));
	
	var dist = dir.clone.multiply(distance);
	var start_pos = new Vector2(x, y);
	var end_pos = start_pos.clone().add(dist);
		
	// Do AABB checks
	var candidates = [];
	var total_colliders = instance_number(obj_collider_static);
	var ray_bbox = { x1 : min(start_pos.x, end_pos.x), y1 : min(start_pos.y, end_pos.y), x2 : max(start_pos.x, end_pos.x), y2 : max(start_pos.y, end_pos.y) };
	
	for(var i = 0; i < total_colliders; i++)
	{
		// Instead of using the collision_shape_AABB_check function we include the raw code for optimization
		var inst = instance_find(obj_collider_static, i);
		if(inst.bbox_left <= ray_bbox.x2 &&
        inst.bbox_right >= ray_bbox.x1 &&
        inst.bbox_top <= ray_bbox.y2 &&
        inst.bbox_bottom >= ray_bbox.y1)
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
				var d = b.clone().subtract(a);
				if ((dir.x * d.y * mirror) + (dir.y * -d.x * mirror) >= 0)
					continue;
					
				// Check for an intersection
				var denominator = (d.y * dist.x) - (d.x * dist.y);
				if (abs(denominator) < 0.0001) // Lines are practically parallel
					continue;

				var v = a.clone().subtract(start_pos);

				var u = ((v.x * dist.y) - (v.y * dist.x)) / denominator;
			    if (u < 0 || u > 1) // Intersection is outside the line segment
					continue;

			    var t = ((v.x * d.y) - (v.y * d.x)) / denominator;
				if (t >= 0 && t < 1.0) 
			    {
					return true;
			    }
			}
		}
	}
	
	return false;
}
