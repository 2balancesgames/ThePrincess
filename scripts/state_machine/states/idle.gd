extends "res://scripts/state_machine/state.gd"

func enter():
	#print("i'm playing idle")
	owner.velocity.x =0
	owner.get_node(^"AnimationPlayer").play("idle")


func update(_delta):
	owner.velocity.x =0
	var input_direction = Input.get_axis("left", "right")
	if input_direction:
		emit_signal("imDoneNow", "move")
		return

	
	#super.handle_input(event)

