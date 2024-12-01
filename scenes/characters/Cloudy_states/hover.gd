extends "res://scripts/state_machine/state.gd"

var hover_height =  -1000
var target_position = Vector2()
var hover_chase_speed = 500
var hover_circle_speed = 1
# var target_center: Vector2 = Vector2(0, -1000)  # Center of the oval
var angle = 0
var width = 800
var height = 400

func enter():
	ScoreManager.cloud_power = 0
	owner.absorbing_souls = true

func update(delta):



	angle += hover_circle_speed * delta

	# Calculate new position
	var x = owner.player_ref.global_position.x  + width * cos(angle)

	var y = hover_height + height * sin(angle)

	# Set the eagle's position
	target_position = Vector2(x, y)


	var direction = owner.global_position.direction_to(target_position)
	owner.velocity = direction * hover_chase_speed
	owner.move_and_slide()
