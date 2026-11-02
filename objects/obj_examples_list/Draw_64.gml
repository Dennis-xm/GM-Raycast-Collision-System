// Grid
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(10, 10, TARGET_WIDTH - 204, TARGET_HEIGHT - 10, false);

draw_set_color(c_white);
draw_set_alpha(1);

draw_set_halign(fa_center);
for(var yy = 0; yy < height_count; yy++)
{
	var first = width_count * yy;
	var count = min(entry_count - first, width_count);
	for(var xx = 0; xx < count; xx++)
	{
		var selected = (xx + first == cur_entry);
		var x_pos = 10 + xx * cell_width + (xx + 1) * cell_padding;
		var y_pos = 10 + yy * cell_height + (yy + 1) * cell_padding;
		
		if(selected)
		{
			draw_set_alpha(0.3);
			draw_rectangle(x_pos, y_pos, x_pos + cell_width, y_pos + cell_height, false);
			draw_set_alpha(1);
		}
		
		var thumbnail_spr = spr_examples_thumbnail;
		
		draw_sprite_ext(thumbnail_spr, 0, x_pos, y_pos, thumb_size, thumb_size, 0, c_white, 1);
		draw_text_ellipsis(x_pos + cell_width / 2, y_pos + 120 * thumb_size - 3, lists[cur_category][|xx + first].name, cell_width);
		
		if(!selected)
		{
			draw_set_color(c_gray);
		}
		draw_rectangle(x_pos, y_pos, x_pos + cell_width, y_pos + cell_height, true);
		draw_set_color(c_white);
	}
}

// Selection
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(TARGET_WIDTH - 200, 10, TARGET_WIDTH - 10, TARGET_HEIGHT - 10, false);

draw_set_color(c_white);
draw_set_alpha(1);

var thumbnail_spr = spr_examples_thumbnail;
draw_sprite(thumbnail_spr, 0, TARGET_WIDTH - 185, 20);

draw_text(TARGET_WIDTH - 105, 140, lists[cur_category][|cur_entry].name);

draw_set_halign(fa_left);
draw_text_ext_transformed(TARGET_WIDTH - 192, 160, lists[cur_category][|cur_entry].desc, 18, 348, 0.5, 0.5, 0);

draw_set_color(#DE3C4B);
draw_rectangle(TARGET_WIDTH - 190, TARGET_HEIGHT - 50, TARGET_WIDTH - 20, TARGET_HEIGHT - 20, false);
draw_set_color(c_white);
draw_text(TARGET_WIDTH - 124, TARGET_HEIGHT - 46, "Enter");
