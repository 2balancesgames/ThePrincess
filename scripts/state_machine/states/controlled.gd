extends "res://scripts/state_machine/state.gd"

var time_length: int = 1


func enter():
	var timer = get_tree().create_timer(time_length)
	timer.timeout.connect(return_control)
	owner.get_node(^"AnimationPlayer").play("new_run")


func update(_delta):
	owner.velocity.x = owner.SPEED_BASE * owner.facing_dir

func return_control():
	emit_signal("imDoneNow", "idle")

