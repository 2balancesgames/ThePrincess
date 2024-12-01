extends "res://scripts/state_machine/state.gd"

@export var move_timer: Timer

const MOVE_WAIT_RANGE: Vector2 = Vector2(3.0, 10.0)

func _ready():
	move_timer.connect("timeout", _on_timer_timeout)
	
func enter():
	#var input_direction = Input.get_axis("left", "right")
	#print("i'm playing run")
	owner.get_node(^"AnimationPlayer").play("walk")
	owner.velocity.x = owner.SPEED * owner.facing_dir
	move_timer.wait_time = randf_range(MOVE_WAIT_RANGE.x, MOVE_WAIT_RANGE.y)
	move_timer.start()

func exit():
	move_timer.stop()

func _on_timer_timeout():
	emit_signal("imDoneNow", "idle")
