image_angle += 0.2;
body.orientation = new Vector2(dcos(image_angle), -dsin(image_angle));
collision_shape_update_vertices(self);

vsp = min(vsp + 0.1, 20);

x += hsp;
y += vsp;

collision_platformer_collide(body, [self]);
