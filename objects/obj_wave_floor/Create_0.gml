shape_type = collision_shape.custom;

vertex_count = 32;
vert_width = 64 / (vertex_count - 1);
vert_height = 64;

vertices = array_create(vertex_count);
edges = array_create(vertex_count - 1);
for(var i = 0; i < vertex_count; i++)
{
	vertices[i] = new Vector2(i * vert_width, vert_height / 2);
	if(i < vertex_count - 1)
		edges[i] = { a : i, b : i+1 };
}

collision_shape_create_world_vertices();

time = 0;
time_mult = 1;

move_shape = true;
has_moved = false;

function update_body(inst, body, attachment)
{
	if(move_shape && has_moved)
	{
		var l = collision_shape_get_edges(self)[attachment.edge_id];
		var a = collision_shape_get_vertices(self)[l.a];
		var b = collision_shape_get_vertices(self)[l.b];
		
		var pos_x = lerp(a.x, b.x, attachment.edge_fraction) + 0.5;
		var pos_y = lerp(a.y, b.y, attachment.edge_fraction) + 0.5;
		var dir = b.clone().subtract(a);
		
		with(inst)
		{
			if(body.can_rotate)
				body.right = dir.normalize();
			x = pos_x + 20 * body.right.y;
			y = pos_y + 20 * -body.right.x;
		}
	}
	
	return body;
}
