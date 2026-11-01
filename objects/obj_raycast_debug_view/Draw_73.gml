// Draw all rays
for(var i = 0; i < ds_list_size(queue); i++)
{
	var ray = queue[| i];
	collision_debug_draw_temp_ray(ray.x, ray.y, ray.direction, ray.distance, ray.color);
}

// Expire rays
if(time_multiplier * global.game_speed > 0)
{
	for(var i = 0; i < ds_list_size(queue); i++)
	{
		if(queue[| i].duration <= 0)
		{
			ds_list_delete(queue, i);
			i--;
		}
		else
			queue[| i].duration -= time_multiplier * global.game_speed;
	}
}
