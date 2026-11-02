enum ExampleCategories
{
	Basic = 0,
	Platformer,
	Count
}

lists = array_create(ExampleCategories.Count);
for(var i = 0; i < ExampleCategories.Count; i++)
{
	lists[i] = ds_list_create();
}

ds_list_add(lists[ExampleCategories.Basic], create_entry("Hub", Hub, -1, "A test of the examples list system. Lalalalalalalala! Lalalalal! Lalala! Hi how are you I am very good thank you very much how are you I am good thank you"));
ds_list_add(lists[ExampleCategories.Basic], create_entry("testing", Hub));
ds_list_add(lists[ExampleCategories.Basic], create_entry("another test", Hub));
ds_list_add(lists[ExampleCategories.Basic], create_entry("hi", Room1));
ds_list_add(lists[ExampleCategories.Platformer], create_entry("Test", Room1));

cur_category = ExampleCategories.Basic;
cur_entry = 0;

box_width = (TARGET_WIDTH - 204) - 10;
cell_width = 83;
cell_height = 78;
cell_padding = 4;
thumb_size = cell_width / 160;

entry_count = ds_list_size(lists[cur_category]);
width_count = floor(box_width / (cell_width + cell_padding));
height_count = ceil(entry_count / width_count);

function create_entry(example_name, example_room, example_thumbnail_id = -1, example_desc = "An example.")
{
	return { name : example_name, target : example_room, desc : example_desc, thumbnail_id : example_thumbnail_id };
}

function draw_text_ellipsis(x, y, str, width)
{
	if(string_width(str) > width)
	{
		var dots = "...";
		var count = string_length(str);
		for(var i = count; i >= 0; i--)
		{
			var part = string_copy(str, 1, i) + dots;
			if(string_width(part) <= width)
			{
				str = part;
				break;
			}
		}
	}
	
	draw_text(x, y, str);
}
