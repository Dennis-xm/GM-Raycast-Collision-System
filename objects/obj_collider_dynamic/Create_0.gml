event_inherited();

time = 0;

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
