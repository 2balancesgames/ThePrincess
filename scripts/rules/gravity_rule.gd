extends Node

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func physics_rule(delta):
	if not owner.is_on_floor():
		owner.velocity.y += gravity * delta
