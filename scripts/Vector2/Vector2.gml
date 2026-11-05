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
	
	/// Adds one vectors value to the vector
	static add = function(other_vector)
	{
		gml_pragma("forceinline");
		x += other_vector.x;
		y += other_vector.y;
		return self;
	}
	
	/// Subtracts one vectors value to the vector
	static subtract = function(other_vector)
	{
		gml_pragma("forceinline");
		x -= other_vector.x;
		y -= other_vector.y;
		return self;
	}
	
	/// Multiplies a value to the vector
	static multiply = function(val)
	{
		gml_pragma("forceinline");
		x *= val;
		y *= val;
		return self;
	}
	
	/// Divides a value to the vector
	static divide = function(val)
	{
		gml_pragma("forceinline");
		x /= val;
		y /= val;
		return self;
	}
	
	/// Creates a new identical vector
	static clone = function()
	{
		gml_pragma("forceinline");
		return new Vector2(x, y);
	}
	
	/// Gets the length of the vector from (0, 0)
	static magnitude = function()
	{
		gml_pragma("forceinline");
		return sqrt((x * x) + (y * y));
	}
	
	/// Gets a normalized variant of the vector (unless zero)
	static normalize = function()
	{
		gml_pragma("forceinline");
		
		var mag = sqrt((x * x) + (y * y));
		if(mag == 0)
			return new Vector2(0, 0);
			
		return new Vector2(x / mag, y / mag);
	}
	
	/// Gets the distance between this vector and the given vector
	static distance = function(other_vector)
	{
		gml_pragma("forceinline");
		return point_distance(x, y, other_vector.x, other_vector.y);
	}
	
	/// Returns true if x and y are both 0
	static is_zero = function()
	{
		gml_pragma("forceinline");
		return (x == 0 && y == 0);
	}
	
	/// Tells Gamemaker how to convert the vector to a string in its "string()" function
	static toString = function()
	{
		gml_pragma("forceinline");
		return "(" + string(x) + ", " + string(y) + ")";
	}
	
	/// Get the dot product between this vector and the given vector
	static dot = function(other_vector)
	{
		gml_pragma("forceinline");
		return dot_product(x, y, other_vector.x, other_vector.y);
	}
	
	/// Converts the vector from world to local space (where right is the given vectors direction)
	static to_local = function(other_vector)
	{
		gml_pragma("forceinline");
		
		var right = other_vector.normalize();
		var old_x = x;
		x = dot_product(x, y, right.x, right.y);
	    y = dot_product(old_x, y, -right.y, right.x);

	    return self;
	}
	
	/// Converts the vector from local to world space (where right is the given vectors direction)
	static to_world = function(other_vector)
	{
		gml_pragma("forceinline");
		
		var right = other_vector.normalize();
		var old_x = x;
		x = x * right.x + y * -right.y;
	    y = old_x * right.y + y * right.x;
		
		return self;
	}
	
	/// Gets a perpendicular version of the vector (always rotated 90 degrees counter-clockwise)
	static perpendicular = function()
	{
		gml_pragma("forceinline");
		return new Vector2(y, -x);
	}
}
