extends CharacterBody2D
class_name Cloudy

const SPEED = 3000.0
const JUMP_VELOCITY = -1000.0
var timer: Timer
const SOUL_BALL = preload("res://scenes/items/Soul.tscn")

@export var rideable: Rideable
@onready var progress = $CollisionShape2D/Cloudy/Progress
@onready var collision_shape_2d = $CollisionShape2D
@onready var state_machine: StateMachine = $StateMachine
var player_ref: Player

const PROGRESS_INIT_POS= -600
var absorbing_souls: bool = true

func _ready():
	set_physics_process(true)
	ScoreManager.cloud_power = 0
	progress.position.x = PROGRESS_INIT_POS
	collision_shape_2d.set_deferred("disabled", true)
	SignalManager.on_enemy_killed.connect(generate_absorb_sould)
	player_ref = get_tree().get_nodes_in_group(GameManager.GROUP_PLAYER)[0]

func increase_cloud_power(point):
	ScoreManager.cloud_power += point
	var new_val =  PROGRESS_INIT_POS + ScoreManager.cloud_power
	if new_val >= 0:
		
		collision_shape_2d.set_deferred("disabled", false)
		
		state_machine.request_change_state("descend")
	progress.position.x = new_val


func generate_absorb_sould(point, pos):
	if absorbing_souls:
		var new_soul_ball = SOUL_BALL.instantiate()
		new_soul_ball.point = 300
		new_soul_ball.global_position = pos
		GameManager.call_add_child(new_soul_ball)


func _on_absorb_body_entered(body):
	if body is Soul:
		if absorbing_souls:
			increase_cloud_power(body.point)
		body.queue_free()


#func move_towards_player():
	#var target_position = player_ref.global_position
	#var tween = get_tree().create_tween()
	#tween.tween_property(self, "global_position", target_position, 2.0)

#func _process(delta):
	#if Input.is_action_just_pressed("ultimate"):
		#move_towards_player()


