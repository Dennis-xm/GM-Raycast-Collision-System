/**
 * GameMaker Raycast Collision System
 * Component: Collision Utils
 * Dependencies: None
 * Copyright (c) 2026 Dennneh | MIT License
 */

/// Returns the calculated direction between point A and B as a vector
function collision_utils_get_direction(a, b, mirror = 1)
{
	var dx = b.x - a.x;
    var dy = b.y - a.y;

    var len = sqrt(dx * dx + dy * dy);

    return { x : dx * mirror / len, y : dy * mirror / len };
}

/// Returns the calculated normal between point A and B as a vector
function collision_utils_get_normal(a, b, mirror = 1)
{
    var dir = collision_utils_get_direction(a, b, mirror);
	/*var dx = dir.x;
	var dy = dir.y;
	
	dir.x = dy;
	dir.y = -dx

    return dir;*/
	return collision_utils_get_perpendicular(dir);
}

function collision_utils_get_perpendicular(vector)
{
	return { x : vector.y, y : -vector.x };
}

function collision_utils_flip_vector(vector)
{
	return { x : -vector.x, y : -vector.y };
}

/// Returns 1 if the object is not mirrored or -1 if it is mirrored.
function collision_utils_get_mirrored(object)
{
	return sign(object.image_xscale) * sign(object.image_yscale);
}

/// Does a simple AABB collision check.
/// @param {Struct} box_1 The first box (needs to contain x1, y1, x2, and y2).
/// @param {Struct} box_2 The second box (needs to contain x1, y1, x2, and y2).
function collision_utils_AABB_check(box_1, box_2)
{
	return (box_1.x1 < box_2.x2 &&
            box_1.x2 > box_2.x1 &&
            box_1.y1 < box_2.y2 &&
            box_1.y2 > box_2.y1);
}

/// Converts the position into a local position based on the given orientation.
/// @param {Struct} pos The position to convert (needs an x and y).
/// @param {Struct} right What is defined as "right" in our local space (as a normal---x and y).
function collision_utils_world_to_local(pos, right)
{
    var x_up = -right.y;
    var y_up = right.x;

    return {
        x : dot_product(pos.x, pos.y, right.x, right.y),
        y : dot_product(pos.x, pos.y, x_up, y_up)
    };
}

/// Converts the position into a world position based on the given orientation.
/// @param {Struct} pos The position to convert (needs an x and y).
/// @param {Struct} right What is defined as "right" in our local space (as a normal---x and y).
function collision_utils_local_to_world(pos, right)
{
    var x_up = -right.y;
    var y_up = right.x;

    return {
        x : pos.x * right.x + pos.y * x_up,
        y : pos.x * right.y + pos.y * y_up
    };
}

function collision_utils_add_normal_rotation(a, b)
{
	return { x : (a.x * b.x) - (a.y * b.y), y : (a.x * b.y) + (a.y * b.x) };
}

function collision_utils_subtract_normal_rotation(a, b)
{
	return { x : (a.x * b.x) + (a.y * b.y), y : (a.y * b.x) - (a.x * b.y) };
}

function collision_utils_normalize(vector)
{
	var mag = sqrt(vector.x * vector.x + vector.y * vector.y);
	vector.x /= mag;
	vector.y /= mag;
	return vector;
}
