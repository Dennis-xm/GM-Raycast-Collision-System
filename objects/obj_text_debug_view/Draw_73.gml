// Draw all messages
for(var i = 0; i < ds_list_size(queue); i++)
{
	var txt = queue[| i];
	draw_set_color(txt.color);
	draw_text(txt.x, txt.y, txt.message);
}
draw_set_color(c_white);

// Expire messages
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
