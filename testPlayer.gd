extends CharacterBody2D


const SPEED = 2000.0
const JUMP_VELOCITY = -9000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var standing_on: CharacterBody2D = null
@onready var collision_shape_2d = $CollisionShape2D

#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#print("air")
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#if standing_on:
		##standing_on.set_physics_process(true)
		##standing_on.velocity.x = velocity.x
		##standing_on.move_and_slide()
		#move_and_slide()
		#print("Standing ", velocity.x, standing_on.velocity.x)
	##else:
		##print("NO Stand ", velocity.x)
	#else:
		#move_and_slide()
	#standing_on = null
#
	#for i in get_slide_collision_count():
		#var co = get_slide_collision(i)
		#var cder = co.get_collider()
		#
		#if cder is CharacterBody2D and co.get_normal().y < -0.7:
			#standing_on = cder
			#return
	#
	##move_and_slide()


func _on_button_pressed():
	if collision_shape_2d.disabled:
		collision_shape_2d.disabled = false
	else:
		collision_shape_2d.disabled = true   # Replace with function body.
