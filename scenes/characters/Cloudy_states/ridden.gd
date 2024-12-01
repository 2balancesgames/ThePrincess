extends "res://scripts/state_machine/state.gd"

@export var rideable: Rideable
@onready var progress = $"../../CollisionShape2D/Cloudy/Progress"

var time_limit: int = 5

func enter():
	get_tree().create_tween().tween_property(progress, "position:x", owner.PROGRESS_INIT_POS, time_limit)
	var timer = get_tree().create_timer(time_limit)
	timer.timeout.connect(back_to_hover)
	#timer.start()


func update(_delta):
	owner.velocity.y = 0
	var direction = Input.get_axis("left", "right")
	if direction:
		owner.velocity.x = direction * owner.SPEED
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0, owner.SPEED)

	rideable.riding_move_and_slide()
	
func back_to_hover():
	rideable.end_ride()
	emit_signal("imDoneNow","hover")
