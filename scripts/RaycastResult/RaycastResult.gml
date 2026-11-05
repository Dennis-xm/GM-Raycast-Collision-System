/**
 * GameMaker Raycast Collision System
 * Component: Raycast Result Type
 * Dependencies: None
 * Copyright (c) 2026 Dennneh | MIT License
 */

/// Return values after a raycast
function RaycastResult() constructor
{
	gml_pragma("forceinline");
	
	point = undefined;
	distance = -1;
	instance = undefined;
	normal = undefined;
	edge_id = -1;
	edge_fraction = -1;
	
}