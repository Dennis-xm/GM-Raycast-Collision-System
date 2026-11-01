hsp = 0;
vsp = 0;

spd = 3;
jump_height = 196;
grv = 0.3;
max_grv = 20;
jumping = false;

body = collision_platformer_create_body();
body.can_rotate = true;
attachment = undefined;
grounded = false;
