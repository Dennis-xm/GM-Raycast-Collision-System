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

if(keyboard_check_pressed(vk_enter))
{
	room_goto(lists[cur_category][|cur_entry].target);
}
