if(global.game_speed == 0)
	return;

x = mouse_x;
y = mouse_y;

if(mouse_check_button_pressed(mb_left) && !drawing)
{
	drawing = true;
	start_mouse.x = x;
	start_mouse.y = y;
}

if(mouse_check_button_released(mb_left) && drawing)
{
	drawing = false;
	var end_mouse = new Vector2(x, y);
	
	len = end_mouse.distance(start_mouse);
	dir = end_mouse.subtract(start_mouse).normalize();
}
if(drawing)
	return;

var hit_results = collision_raycast(x, y, dir, len);

collision_debug_draw_ray(x, y, dir, len, (hit_results == undefined) ? c_green : c_red);

if(hit_results != undefined)
{
	debug_draw_text(x - 20, y - 72, "Point: " + string(hit_results.point), c_white);
	debug_draw_text(x - 20, y - 60, "Distance: " + string(hit_results.distance), c_white);
	debug_draw_text(x - 20, y - 48, "Instance: " + string(hit_results.instance), c_white);
	debug_draw_text(x - 20, y - 36, "Normal: " + string(hit_results.normal), c_white);
	debug_draw_text(x - 20, y - 24, "Edge ID: " + string(hit_results.edge_id), c_white);
	debug_draw_text(x - 20, y - 12, "Edge Frac: " + string(hit_results.edge_fraction), c_white);
}
