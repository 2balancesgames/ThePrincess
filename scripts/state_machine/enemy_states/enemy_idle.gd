extends "res://scripts/state_machine/state.gd"
const IDLE_WAIT_RANGE: Vector2 = Vector2(1.0, 3.0)


@onready var idle_timer = $"../../timers/IdleTimer"

func _ready():
	idle_timer.connect("timeout",_on_timer_timeout)

func enter():
	owner.velocity.x =0
	owner.get_node(^"AnimationPlayer").play("idle")

	idle_timer.wait_time = randf_range(IDLE_WAIT_RANGE.x, IDLE_WAIT_RANGE.y)

	idle_timer.start()



func update(delta):
	PhysicsUtils.apply_gravity(owner,delta)
	owner.move_and_slide()
	if idle_timer.time_left>0:
		print(idle_timer.time_left)
	return


func _on_timer_timeout():
	print("i'm called")
	emit_signal("imDoneNow", "move") # Replace with function body.
