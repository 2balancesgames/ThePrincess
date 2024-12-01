extends "res://scripts/state_machine/state.gd"



func enter():
	hold_on=true
	owner.velocity.x =0
	owner.get_node(^"AnimationPlayer").play("held")


	
