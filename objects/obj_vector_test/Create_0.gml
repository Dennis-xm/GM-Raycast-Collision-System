vector = new Vector2(0, 0);

vecClone = vector.clone();
vecClone.x += 40;
vecClone.y += 20;

vecAdd = new Vector2(20, 20).add(vecClone);
vecSub = vecAdd.clone().subtract(new Vector2(15, 60));
vecMul = vecClone.clone().multiply(5);
vecDiv = vecMul.clone().divide(1.5);

vecStack = new Vector2(20, 30).multiply(4).add(new Vector2(10, 20)).divide(2).subtract(new Vector2(5, 5));
vecNorm = new Vector2(-1, -1).normalize().multiply(50);

timer = 0;


function draw_from_name(variable, to_str = false)
{
	var vec = variable_instance_get(id, variable);
	var zero = vec.is_zero();
	
	if(zero)
	{
		draw_set_color(c_aqua);
	}
	
	draw_circle(vec.x + x, vec.y + y, 2, false);
	
	if(!to_str)
	{
		draw_text(vec.x + x, vec.y + y, variable);
	}
	else
	{
		draw_text(vec.x + x, vec.y + y, string(vec));
	}
	
	if(zero)
	{
		draw_set_color(c_white);
	}
}
