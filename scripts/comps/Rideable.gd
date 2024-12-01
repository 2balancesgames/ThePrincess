extends Node

class_name Rideable

var rider: CharacterBody2D = null
var ready_for_ride: bool = false

@export var ridden_state_name: String = "ridden"
@export var idle_state_name: String = "hover"

func start_ride(character: CharacterBody2D):
	#if ready_for_ride:
	rider = character
	rider.set_physics_process(false)
	owner.state_machine.request_change_state(ridden_state_name)


func end_ride():
	if rider:
		#ready_for_ride = false
		owner.get_child(0).disabled = true # disable the collision
		rider.set_physics_process(true)
		rider = null
		owner.state_machine.request_change_state(idle_state_name)


func riding_move_and_slide():
	owner.move_and_slide()
	rider.velocity = owner.velocity
	rider.move_and_slide()

