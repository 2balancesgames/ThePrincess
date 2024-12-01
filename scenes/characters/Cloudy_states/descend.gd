
extends "res://scripts/state_machine/state.gd"

var hover_height =  600
var target_position = Vector2()
var hover_chase_speed = 800
var hover_circle_speed = 1
# var target_center: Vector2 = Vector2(0, -1000)  # Center of the oval
var angle = 0
var width = 800
var height = 400

func enter():
	owner.absorbing_souls = false
	
	

func update(_delta):
	# Set the eagle's position
	if owner.global_position.distance_to(owner.player_ref.global_position) < 900:
		return
	target_position = Vector2(owner.player_ref.global_position.x - 300, hover_height)
	
	var direction = owner.global_position.direction_to(target_position)
	owner.velocity = direction * hover_chase_speed
	owner.move_and_slide()

