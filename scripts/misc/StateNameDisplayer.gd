extends Label

var start_position = Vector2()

func _ready():
	start_position = position
	text = String(owner.get_name())
#
#func _physics_process(_delta):
	#text = "Right" if PhysicsUtils.DIRECTION > 0   else "left"
	#var iof = owner.is_on_floor()
	#text = "yes" if iof else "no"

func _on_state_machine_state_changed(current_state):
	if owner.facing_dir == 1:
		text = String("1") + "." + String(current_state.get_name()) 
