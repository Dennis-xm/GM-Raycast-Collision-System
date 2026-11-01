if(global.game_speed <= 0)
	return;

time++;

x += dsin(time * 4) * 2;
y += dcos(time * 8) * 4;
image_angle = dsin(time * 2) * 20;

collision_shape_update_vertices(self);

has_moved = true;
