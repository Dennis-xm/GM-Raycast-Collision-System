if(keyboard_check_pressed(STEPPER_TOGGLE_BIND))
	stepper = !stepper;

if(stepper)
{
	if(keyboard_check_pressed(STEPPER_STEP_BIND))
		global.game_speed = 1;
	else
		global.game_speed = 0;
}
else
	global.game_speed = 1;
