extends Node

var DIRECTION = 0.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.5
var wind = 1

signal directionChanged(direction)

func apply_gravity(node :CharacterBody2D, delta: float) -> void:
	if not node.is_on_floor():
		node.velocity.y += gravity * delta


func apply_air_accel(node :Player, delta: float) -> void:
	#print("apply air accel")
	var air_accel = (node.air_steering_power + node.air_acceleration) * delta * Input.get_axis("left", "right")
	#print("a: ", air_accel)
	#print("nv;; ", node.velocity.x)
	var horizontal_velocity = node.velocity.x  + air_accel # + wind * delta 
	#print("h: " ,horizontal_velocity)
	node.velocity.x = clamp(horizontal_velocity, -node.max_horizontal_speed, node.max_horizontal_speed)
	#print("x: ", node.velocity.x)

func turn_the_node(node :CharacterBody2D) -> void:
	var towards = Input.get_axis("left", "right")
	if towards + node.facing_dir == 0 : # this means they are opposite
		node.facing_dir = towards
		node.scale.x *= -1 
