hsp = 0;
vsp = 0;
edge_count = 20;

// Collision shape
shape_type = collision_shape.custom;
vertices = []
edges = []

// Collision body
body = collision_platformer_create_body_empty();
body.cur_layout = "default";
body.layouts[$ "default"] = [];

// Create the collision data
for(var i = 0; i < edge_count; i++)
{
	// Collision shape
	var ang = (360 / edge_count) * i;
	vertices[i] = new Vector2(dcos(ang) * 64, dsin(ang) * 64);
	
	if(i >= edge_count - 1)
		edges[i] = { a : i, b : 0 };
	else
		edges[i] = { a : i, b : i+1 };
		
	// Collision body
	array_push(body.layouts[$ "default"], { x_offset : 0, y_offset : 0, direction : new Vector2(dcos(ang) , dsin(ang)), distance : 64, group : layout_ray_group.dynamic });
}
collision_shape_create_world_vertices();
