extends "res://scripts/state_machine/state.gd"

func enter():
	owner.get_node(^"AnimationPlayer").play("fall")


func update(_delta):
	if owner.is_on_floor():
		emit_signal("imDoneNow", "idle")
		return

