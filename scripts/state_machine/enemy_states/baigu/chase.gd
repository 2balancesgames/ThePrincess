extends "res://scripts/state_machine/state.gd"

#@export var move_timer: Timer

@onready var front_detector = $"../../frontDetector"

#func _ready():
	#move_timer.connect("timeout", _on_timer_timeout)
	
func enter():
	#var input_direction = Input.get_axis("left", "right")
	#print("i'm playing run")
	owner.get_node(^"AnimationPlayer").play("walk")
	owner.velocity.x = owner.SPEED * owner.facing_dir * owner.CHASE_FACTOR


func update(delta):
	if not front_detector.is_colliding():
		emit_signal("imDoneNow","idle")
	



#func _on_timer_timeout():
	#emit_signal("imDoneNow", "idle")
