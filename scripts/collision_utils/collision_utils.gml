/**
 * GameMaker Raycast Collision System
 * Component: Collision Utils
 * Dependencies: None
 * Copyright (c) 2026 Dennneh | MIT License
 */

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

function collision_utils_add_normal_rotation(a, b)
{
	return new Vector2((a.x * b.x) - (a.y * b.y), (a.x * b.y) + (a.y * b.x));
}

function collision_utils_subtract_normal_rotation(a, b)
{
	return new Vector2((a.x * b.x) + (a.y * b.y), (a.y * b.x) - (a.x * b.y));
}

function collision_utils_normalize(vector)
{
	var mag = sqrt(vector.x * vector.x + vector.y * vector.y);
	vector.x /= mag;
	vector.y /= mag;
	return vector;
}
