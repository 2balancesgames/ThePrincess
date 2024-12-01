extends CharacterBody2D

class_name Player

var SPEED_BASE = 2000.0
var JUMP_VELOCITY = -6000.0
var air_acceleration: float =  100.0
var air_steering_power: float = 1000.0
var max_horizontal_speed = 8000.0


var facing_dir = 1
var strength = 1
var riding_on: CharacterBody2D = null

var normal_common_physics: bool = true


@onready var state_machine: StateMachine = $StateMachine
@onready var back_bar: Area2D = $"sprites/BackBar/BarArea"
@onready var front_bar: Area2D = $"sprites/FrontBar/BarArea"
@onready var weapons: Array[Area2D] = [front_bar, back_bar]

var held_buff:int = 0
var MAX_HELD_BUFF:int = 4


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	SignalManager.grab_started.connect(start_being_held)
	SignalManager.weapons_off.connect(withdraw_weapons)

func _physics_process(delta):

	if normal_common_physics:
		if Input.get_axis("left", "right")>0 and facing_dir == -1 : # this means they are opposite
			turn_around()
		elif Input.get_axis("left", "right")<0 and facing_dir == 1 :
			turn_around()

		PhysicsUtils.apply_gravity(self,delta)
		if not is_on_floor():
			PhysicsUtils.apply_air_accel(self, delta)
		
	move_and_slide()
	var collision = get_last_slide_collision()
	if not collision: return
	var collider = collision.get_collider()
	if collider is Jutu:
		#var normal = collision.get_normal()
		#var angle = collision.get_angle()
		#print(angle)
		#print(normal)
		#velocity = 10000 * normal

		velocity.x=-9000

		state_machine.request_change_state("jump")


	for i in get_slide_collision_count():
		var co = get_slide_collision(i)
		var cder = co.get_collider()

		if cder is Cloudy and co.get_normal().y < -0.7: # TODO: use is ridable
			riding_on = cder
			if facing_dir == -1:
				turn_around()
			state_machine.request_change_state("idle")
			set_physics_process(false)
			riding_on.rideable.start_ride(self)
			return

	riding_on = null



	#
func _unhandled_input(event):
	if Input.is_action_just_pressed("special"):
		state_machine.request_change_state("dash")
		return

	if Input.is_action_just_pressed("jump") and is_on_floor():
		if riding_on:
			riding_on.rideable.end_ride()
		state_machine.request_change_state("jump")

		return
	if event.is_action_pressed("fight"):
		if state_machine.current_state.get_name() == "held":
			reduce_buff(strength)
			return
		state_machine.request_change_state("fight")
		return

func turn_around():
	facing_dir = -facing_dir
	$".".scale.x *= -1

func withdraw_weapons():
	print("off")
	front_bar.monitorable=false
	front_bar.monitorable=false

func start_being_held(_playerself, _grabber, buff):
	state_machine.request_change_state('held', true)
	held_buff += buff
	if held_buff > MAX_HELD_BUFF:
		held_buff = MAX_HELD_BUFF


func reduce_buff(buff):
	held_buff -= buff
	if held_buff <= 0:
		held_buff = 0
		SignalManager.emit_signal("", 10000)
		state_machine.request_change_state("idle", true)


func increase_speed_base(amt):
	SPEED_BASE += amt

func get_controlled():
	state_machine.request_change_state("controlled", true)
