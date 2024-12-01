extends CharacterBody2D

class_name EnemyBase

#enum FACING {LEFT = -1, RIGHT = 1}
var SPEED = 300.0
var CHASE_FACTOR = 2
var ATTACK_FACTOR = 8
const JUMP_VELOCITY = -400.0
const points = 5
const OFF_SCREEN_KILL_ME = 8000
var default_facing: int = -1
var facing_dir:int  = default_facing
var player_ref: Player
# Get the gravity from the project settings to be synced with RigidBody nodes.
var died:bool = false


func _ready():
	var player_group = get_tree().get_nodes_in_group(GameManager.GROUP_PLAYER)
	if not player_group:
		queue_free()
		return
	else:
		player_ref = player_group[0]
func _physics_process(delta):
	PhysicsUtils.apply_gravity(self,delta)
	move_and_slide()
	fallen_off()

func flip():
	facing_dir = -facing_dir
	$".".scale.x *= -1


func fallen_off() -> void:
	if global_position.y > OFF_SCREEN_KILL_ME:
		queue_free()

func die():
	if died: # already died
		return

	died = true
	SignalManager.on_enemy_killed.emit(points, global_position)
	set_physics_process(false)
	#hide()
	queue_free()



func _on_visible_on_screen_notifier_2d_screen_entered():
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.
