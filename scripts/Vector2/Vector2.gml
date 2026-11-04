/**
 * GameMaker Raycast Collision System
 * Component: Vector2 Type
 * Dependencies: None
 * Copyright (c) 2026 Dennneh | MIT License
 */

/// A Vector2 type storing 'x' and 'y'
function Vector2(_x, _y) constructor
{
	gml_pragma("forceinline");
	x = _x;
	y = _y;
	
	static add = function(other_vector)
	{
		gml_pragma("forceinline");
		x += other_vector.x;
		y += other_vector.y;
		return self;
	}
	
	static subtract = function(other_vector)
	{
		gml_pragma("forceinline");
		x -= other_vector.x;
		y -= other_vector.y;
		return self;
	}
	
	static multiply = function(val)
	{
		gml_pragma("forceinline");
		x *= val;
		y *= val;
		return self;
	}
	
	static divide = function(val)
	{
		gml_pragma("forceinline");
		x /= val;
		y /= val;
		return self;
	}
	
	static clone = function()
	{
		gml_pragma("forceinline");
		return new Vector2(x, y);
	}
	
	static magnitude = function()
	{
		gml_pragma("forceinline");
		return sqrt((x * x) + (y * y));
	}
	
	static normalize = function()
	{
		gml_pragma("forceinline");
		
		var mag = sqrt((x * x) + (y * y));
		if(mag == 0)
			return new Vector2(0, 0);
			
		return new Vector2(x / mag, y / mag);
	}
	
	static distance = function(other_vector)
	{
		gml_pragma("forceinline");
		return point_distance(x, y, other_vector.x, other_vector.y);
	}
	
	static is_zero = function()
	{
		gml_pragma("forceinline");
		return (x == 0 && y == 0);
	}
	
	static toString = function()
	{
		gml_pragma("forceinline");
		return "(" + string(x) + ", " + string(y) + ")";
	}
}
