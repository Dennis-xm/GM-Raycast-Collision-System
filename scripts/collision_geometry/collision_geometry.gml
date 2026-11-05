/**
 * GameMaker Raycast Collision System
 * Component: Collision Geometry
 * Dependencies: None
 * Copyright (c) 2026 Dennneh | MIT License
 */

enum collision_shape
{
	custom = -1,
	rectangle,
	slope
}

/// Internal collision function, includes all the geometry for all predefined collision shapes.
function collision_shape_library()
{
    static shapes = [];

	// In here we can define the different shapes.
	// Vertices just store a 2D position (x and y, using a Vector2).
	// Edges are what connect these vertices with A being the starting point and B being the end point.
	// These use the ID of the vertices. Edges can also include additional information edge specific.
    if (array_length(shapes) == 0)
    {
        shapes[collision_shape.rectangle] = {
            vertices : [ new Vector2(0, 0), new Vector2(32, 0), new Vector2(32, 32), new Vector2(0, 32) ],
            edges    : [ { a : 0, b : 1 }, { a : 1, b : 2 }, { a : 2, b : 3 }, { a : 3, b : 0 } ]
        };
		
		shapes[collision_shape.slope] = {
            vertices : [ new Vector2(64, 0), new Vector2(64, 64), new Vector2(0, 64) ],
            edges    : [ { a : 0, b : 1 }, { a : 1, b : 2 }, { a : 2, b : 0 } ]
        };

        // etc...
    }

    return shapes;
}

/// Returns an array of the objects vertices translated to world space.
function collision_shape_get_vertices(object)
{
	if(variable_instance_exists(object, "world_vertices"))
		return object.world_vertices;
	
	return pointer_null;
}

/// Returns an array of the objects vertices in local space.
function collision_shape_get_local_vertices(object)
{
	if(variable_instance_exists(object, "shape_type") && object.shape_type != collision_shape.custom)
	{
		return collision_shape_library()[object.shape_type].vertices;
	}
	else if(variable_instance_exists(object, "vertices"))
		return object.vertices;
	
	return pointer_null;
}

/// Returns an array of the objects edges.
function collision_shape_get_edges(object)
{
	if(variable_instance_exists(object, "shape_type") && object.shape_type != collision_shape.custom)
	{
		return collision_shape_library()[object.shape_type].edges;
	}
	else if(variable_instance_exists(object, "edges"))
		return object.edges;
	
	return pointer_null;
}

/// Updates the objects world-space vertices based on the objects own transformation.
function collision_shape_update_vertices(object)
{
	// Make sure we are able to actually do this
	if(variable_instance_exists(object, "world_vertices"))
	{
		var verts = collision_shape_get_local_vertices(object);
		if(is_array(verts))
		{
			// Prepare the array and the sin and cos values
			array_resize(object.world_vertices, array_length(verts));
			
			var c = dcos(object.image_angle);
			var s = dsin(object.image_angle);
			
			// Convert each vertex into world space (scale -> rotation -> position)
			for(var i = 0; i < array_length(verts); i++)
			{
				var xx = verts[i].x * object.image_xscale;
				var yy = verts[i].y * object.image_yscale;
				
				var dx = (xx * c + yy * s) + object.x;
				var dy = (yy * c - xx * s) + object.y;
				
				if(is_struct(object.world_vertices[i]))
				{
					object.world_vertices[i].x = dx;
					object.world_vertices[i].y = dy;
				}
				else
					object.world_vertices[i] = new Vector2(dx, dy);
			}
			return;
		}
	}
	
	show_debug_message("Could not transform vertices of object '" + object + "'.");
}

/// Creates the 'world_vertices' array and populates it based on the calling objects collision shape.
function collision_shape_create_world_vertices()
{
	world_vertices = [];
	collision_shape_update_vertices(self);
}
