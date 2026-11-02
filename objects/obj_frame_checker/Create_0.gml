// This object helps you check game events frame by frame, which is very useful for collision debugging especially.
// The stepper doesn't do anything on its own though, all things affected by the stepper (which ideally should be everything)
// needs to use global.game_speed in different parts.
// Recommended is if you use this to add the global variable to a script outside of a function in order to avoid errors
// regarding trying to access a variable that doesn't exist yet.

#macro STEPPER_TOGGLE_BIND ord("K")
#macro STEPPER_STEP_BIND ord("L")

stepper = false;
if(!variable_global_exists("game_speed"))
{
	// If you want to be able to use this you have to hook all physics things to the game speed global.
	// All that's important is whether the game speed is more than one or not (for the stepper its always 1 or 0).
	global.game_speed = 1;
}
