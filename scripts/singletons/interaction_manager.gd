
# InteractionManager.gd
extends Node2D



var active_joints: Dictionary = {}  # Store active grab connections
#
#func _ready():
	## Ensure this node is in the scene tree and persists
	#process_mode = Node.PROCESS_MODE_ALWAYS

func can_grab(grabber: Node2D, target: Node2D, grab_range: float) -> bool:
	# Check if grabbing is possible based on distance
	var distance = grabber.global_position.distance_to(target.global_position)
	return distance <= grab_range

func initiate_grab(enemy: CharacterBody2D, player: CharacterBody2D, grab_range: float = 50.0) -> bool:
	# Check if grab already exists
	var grab_id = _get_grab_id(enemy, player)
	if active_joints.has(grab_id):
		return false
	
	## Verify grab is possible
	#if not can_grab(enemy, player, grab_range):
		#return false
	
	# Create and configure PinJoint2D
	var joint = PinJoint2D.new()
	joint.name = grab_id
	joint.node_a = enemy.get_path()
	joint.node_b = player.get_path()
	joint.softness = 0.0  # Adjust this value for different grab "feels"
	var debug_draw = JointDebugDraw.new()
	debug_draw.name = "DebugDraw"
	joint.add_child(debug_draw)
	# Add joint to scene
	add_child(joint)
	active_joints[grab_id] = joint
	
	# Emit signal
	#SignalManager.emit_signal("grab_started", player, enemy, 2)
	return true

func end_grab(enemy: CharacterBody2D, player: CharacterBody2D) -> void:
	var grab_id = _get_grab_id(enemy, player)
	if active_joints.has(grab_id):
		var joint = active_joints[grab_id]
		joint.queue_free()
		active_joints.erase(grab_id)
		emit_signal("grab_ended", player, enemy)

func _get_grab_id(enemy: CharacterBody2D, player: CharacterBody2D) -> String:
	# Create unique identifier for this grab connection
	return "grab_%s_%s" % [enemy.get_instance_id(), player.get_instance_id()]

# Optional: Clean up any lingering joints when scene changes
func _exit_tree():
	for joint in active_joints.values():
		if is_instance_valid(joint):
			joint.queue_free()
	active_joints.clear()
