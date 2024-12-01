extends "res://scripts/state_machine/state.gd"


func enter():
	owner.get_node(^"AnimationPlayer").play("new_run")


func update(_delta):
	owner.velocity.x = owner.SPEED_BASE * owner.facing_dir
	var input_direction = Input.get_axis("left", "right")
	if input_direction == 0 :
		emit_signal("imDoneNow", "idle")

