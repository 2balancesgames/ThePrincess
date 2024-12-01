extends EnemyBase

class_name Jutu2

@onready var hitbox = $Hitbox

var state_machine: StateMachine
var invincible: bool = false
@onready var floor_detection = $FloorDetection
@onready var front_detector = $frontDetector
@onready var back_detector = $backDetector
@onready var attack_trigger = $attackTrigger

@onready var label = $Label
@onready var trail_effect = $TrailEffect


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	label.text = str(GameManager.Baigu_num)
	GameManager.Baigu_num +=1
	state_machine = $StateMachine
#	position.x += (2000 + randf()*1000)



func _physics_process(delta):
	super._physics_process(delta)

	if state_machine.current_state.hold_on:
		return
	if attack_trigger.is_colliding():
		state_machine.request_change_state("fight")
		return
	if front_detector.is_colliding():
		state_machine.request_change_state("chase")
		return
	if back_detector.is_colliding() or (is_on_wall() and !attack_trigger.is_colliding()) or !floor_detection.is_colliding():
		flip()
		state_machine.request_change_state("idle")
		return

func shock_wave(wave):
	invincible = false
	velocity.x = -facing_dir*wave
	trail_effect.start_trail()
	move_and_slide()
	state_machine.request_change_state("idle")


func _on_hitbox_area_entered(area):
	print("on hitbox entered", area)


func _on_hitbox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("on shape entered") # Replace with function body.
	if invincible:
		return
	hitbox.queue_free()
	state_machine.request_change_state("die", true)


func _on_hitbox_body_entered(body):
	print("on body entered", body) # Replace with function body.

