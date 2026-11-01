if(global.game_speed <= 0)
	return;

time += time_mult;
time_mult = max(lerp(time_mult, 0.9, 0.1), 1);
//x += dsin(time);
//y += dcos(time * 2) * 2;
//image_angle = dsin(time) * 4;

for(var i = 0; i < vertex_count; i++)
{
	var mult = 1 - (abs(i - (vertex_count - 1) / 2)) / ((vertex_count - 1) / 2);
	vertices[i].y = (dsin((time + i * 8) * 4) * mult + 1) * vert_height / 2;
}
collision_shape_update_vertices(self);

has_moved = true;
