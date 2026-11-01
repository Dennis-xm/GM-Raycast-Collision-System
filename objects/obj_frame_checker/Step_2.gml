if(keyboard_check_pressed(ord("K")))
	stepper = !stepper;

if(stepper)
{
	if(keyboard_check_pressed(ord("L")))
		global.game_speed = 1;
	else
		global.game_speed = 0;
}
else
	global.game_speed = 1;
