extends RigidBody2D
class_name  Soul
var target: CharacterBody2D  # The position you want to tween to
#var tween_duration = 2.0  # Duration of the tween in seconds
var force_magnitude = 1000  # Adjust this based on your needs

var point : int = 0
#var tween: Tween
#
func _ready():
	target = get_tree().get_nodes_in_group(GameManager.GROUP_CLOUDY)[0]
	#tween = get_tree().create_tween()
	#tween.tween_property(self, "global_position", target_position, tween_duration)
	#tween.set_trans(Tween.TRANS_SINE)
	#tween.set_ease(Tween.EASE_IN_OUT)

func _physics_process(delta):
	if not target:
		queue_free()
		return
		
	var direction = (target.global_position - global_position).normalized()
	var force = direction * force_magnitude
	apply_central_force(force)

