if(keyboard_check_pressed(vk_right))
{
	if(cur_entry < entry_count - 1)
	{
		cur_entry++;
	}
}
if(keyboard_check_pressed(vk_left))
{
	if(cur_entry > 0)
	{
		cur_entry--;
	}
}
if(keyboard_check_pressed(vk_down))
{
	if(cur_entry + width_count < entry_count)
	{
		cur_entry += 3;
	}
}
if(keyboard_check_pressed(vk_up))
{
	if(cur_entry - 3 >= 0)
	{
		cur_entry -= 3;
	}
}

if(mouse_check_button_pressed(mb_left))
{
	if(mouse_x >= 10 && mouse_x <= TARGET_WIDTH - 204
	&& mouse_y >= 10 && mouse_y <= TARGET_HEIGHT - 10)
	{
		var mx = mouse_x - 10;
		var my = mouse_y - 10;
		
		var gx = floor(mx / cell_width);
		var gy = floor(my / cell_height);
		
		var entry = (gy * width_count) + gx;
		if(entry >= 0 && entry < entry_count)
		{
			cur_entry = entry;
		}
	}
	else if(mouse_x >= TARGET_WIDTH - 190 && mouse_x <= TARGET_WIDTH - 20
	&& mouse_y >= TARGET_HEIGHT - 50 && mouse_y <= TARGET_HEIGHT - 20)
	{
		room_goto(lists[cur_category][|cur_entry].target);
	}
}

if(keyboard_check_pressed(vk_enter))
{
	room_goto(lists[cur_category][|cur_entry].target);
}
