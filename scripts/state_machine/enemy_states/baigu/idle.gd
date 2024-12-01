extends "res://scripts/state_machine/state.gd"
const IDLE_WAIT_RANGE: Vector2 = Vector2(3.0, 8.0)

#@onready var idle_timer = $IdleTimer
@export var idle_timer:Timer

func _ready():
	idle_timer.connect("timeout",_on_timer_timeout)

func enter():
	owner.velocity.x =0
	owner.get_node(^"AnimationPlayer").play("idle")
	
	idle_timer.wait_time = randf_range(IDLE_WAIT_RANGE.x, IDLE_WAIT_RANGE.y)
	idle_timer.start()



func _on_timer_timeout():
	emit_signal("imDoneNow", "move") # Replace with function body.

func exit():
	idle_timer.stop()
