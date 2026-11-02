// This object draws all rays requested to be drawn. The collision debug functions does allow for
// object free raycast rendering, but using this object comes with pros such as persistent lines between frames,
// the draw call can be called outside of a draw event, and it's just kind of neat in general.

time_multiplier = 1;
queue = ds_list_create();

if(!variable_global_exists("game_speed"))
{
	// Check "obj_frame_checker" for more information about this global.
	global.game_speed = 1;
}
