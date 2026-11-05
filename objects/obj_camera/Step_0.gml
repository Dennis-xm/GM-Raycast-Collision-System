if(mouse_check_button(mb_middle) || mouse_check_button(mb_right))
{
	x -= (window_mouse_get_delta_x() / 2) * zoom;
	y -= (window_mouse_get_delta_y() / 2) * zoom;
}

if(mouse_wheel_up())
	zoom /= 2;
if(mouse_wheel_down())
	zoom *= 2;

camera_set_view_pos(cam, floor((x - (width * zoom) / 2) / zoom) * zoom, floor((y - (height * zoom) / 2) / zoom) * zoom);
camera_set_view_size(cam, width * zoom, height * zoom);
camera_apply(cam);
