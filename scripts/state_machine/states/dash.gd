extends "res://scripts/state_machine/state.gd"

var facing_dir
@export var dashing_factor :int
@export var dashing_duration: float
@export var trail_effect: TrailEffect
# Called when the node enters the scene tree for the first time.
func enter():
	owner.get_node(^"AnimationPlayer").play("dash") #
	facing_dir = owner.facing_dir
	owner.normal_common_physics = false
	
	var timer = Timer.new()
	timer.wait_time = dashing_duration  # Set the timer to 0.25 seconds
	timer.one_shot = true  # Make the timer run only once
	timer.timeout.connect(back_to_idle)
	add_child(timer)
	timer.start()
	trail_effect.start_trail()
	
	
	#var timer = get_tree().create_timer(dashing_duration)

# Called every frame. 'delta' is the elapsed time since the previous frame.

func update(delta):
	owner.velocity.x = owner.SPEED_BASE * facing_dir * dashing_factor
	owner.velocity.y = 0
	
func exit():
	owner.normal_common_physics = true


func back_to_idle():
	emit_signal("imDoneNow","idle")
	trail_effect.stop_trail()
