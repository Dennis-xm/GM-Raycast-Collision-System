// This object allows you to draw persistant text in world space.
// The main benefit of this is mainly for debugging reasons. Instead of having to manually save the information
// you want to render until a draw event, or even worse recompute it, with this you can instead draw text
// inside of the logic loop itself.

time_multiplier = 1;
queue = ds_list_create();

if(!variable_global_exists("game_speed"))
{
	// Check "obj_frame_checker" for more information about this global.
	global.game_speed = 1;
}
