extends "res://scripts/state_machine/state.gd"

@export var clean_up_timer: Timer
# Called when the node enters the scene tree for the first time.

func _ready():
	hold_on = true
	final = true
	clean_up_timer.connect("timeout", owner.die)

func enter():
	#super.enter()
	owner.velocity.x =0
	owner.get_node(^"AnimationPlayer").play("die")

	clean_up_timer.start()

#func update(_delta):
	#PhysicsUtils.apply_gravity(owner,_delta)
	#owner.move_and_slide()
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
