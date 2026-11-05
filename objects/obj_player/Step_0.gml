if(global.game_speed <= 0)
	return;

if(attachment != undefined && (attachment.instance.object_index == obj_collider_dynamic || object_is_ancestor(attachment.instance.object_index, obj_collider_dynamic)))
	body = attachment.instance.update_body(self, body, attachment);
else
	body = collision_platformer_rotate_body(body, new Vector2(1, 0), x, y);

hsp = spd * (keyboard_check(vk_right) - keyboard_check(vk_left));
if(!grounded)
	vsp = min(vsp + grv, max_grv);
else
	vsp = 0;

if(jumping)
{
	if(vsp >= 0 || grounded)
		jumping = false;
	else if(!keyboard_check(ord("Z")))
	{
		vsp /= 3;
		jumping = false;
	}
}
if(keyboard_check_pressed(ord("Z")) && grounded)
{
	vsp = -sqrt(2 * grv * jump_height);
	grounded = false;
	jumping = true;
	
	show_debug_message("jump");
}

if(attachment != undefined && keyboard_check_pressed(ord("X")))
{
	body = collision_platformer_rotate_body(body, attachment.normal, attachment.point_x, attachment.point_y);
}

body.stick = grounded;
attachment = collision_platformer_collide(body, [], true);
