var show_pos = (floor(timer / 100) % 2);

draw_from_name("vector", show_pos);
draw_from_name("vecClone", show_pos);

draw_from_name("vecAdd", show_pos);
draw_from_name("vecSub", show_pos);
draw_from_name("vecMul", show_pos);
draw_from_name("vecDiv", show_pos);

draw_from_name("vecStack", show_pos);
draw_from_name("vecNorm", show_pos);

draw_text(vecNorm.x + x, vecNorm.y + y - 24, string(vecNorm.magnitude()));
draw_line(vecAdd.x + x, vecAdd.y + y, vecStack.x + x, vecStack.y + y);
draw_text(vecStack.x + x - 50, vecStack.y + y - 10, string(vecAdd.distance(vecStack)));

