extends "res://scripts/state_machine/state.gd"


func enter():
	owner.velocity.y = owner.JUMP_VELOCITY
	#owner.move_and_slide()
	owner.get_node(^"AnimationPlayer").play("jump")


func update(delta):
	if owner.is_on_floor():
		emit_signal("imDoneNow","idle")
		return
	
	if owner.velocity.y > 0: 
		emit_signal("imDoneNow","fall")
		return



