@tool
extends Node
class_name Utils

static func calculate_distance(point_a: Vector2, point_b: Vector2) -> float:
	return point_a.distance_to(point_b)

static func clamp_value(value: float, min_value: float, max_value: float) -> float:
	return clamp(value, min_value, max_value)
	


