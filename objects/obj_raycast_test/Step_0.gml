x = mouse_x;
y = mouse_y;

var hit_results = collision_raycast(x, y, new Vector2(0, 1), 32);

collision_debug_draw_ray(x, y, new Vector2(0, 1), 32, (hit_results == undefined) ? c_green : c_red);
