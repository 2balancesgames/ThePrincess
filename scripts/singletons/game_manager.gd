extends Node

const GROUP_PLAYER: String = "player"
const GROUP_CLOUDY: String = "cloudy"
var _current_level: int = -1
#var _level_scenes = {
	#0: load("res://scenes/levels/level_0.tscn"),
	#1: load("res://scenes/levels/level_1.tscn"),
#}


const TOTAL_LEVELS: int = 3

#const BAIGU = preload("res://scenes/enemies/baigu2.tscn")
#const JUTU = preload("res://scenes/enemies/jutu.tscn")
#var holding_player_zone
var Baigu_num = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)
	
func call_add_child(child_to_add)->void:
	call_deferred("add_child_deferred", child_to_add)

func set_next_level() -> void:
	_current_level += 1
	if _current_level > TOTAL_LEVELS:
		_current_level = 0

func load_main_scene() -> void:
	_current_level = -1
	ScoreManager.reset()
	get_tree().change_scene_to_packed(load("res://scenes/levels/Main.tscn"))
	get_tree().paused= false
	
func load_interscene()-> void:
	get_tree().change_scene_to_packed(load("res://scenes/HUD/InterScenes.tscn"))

func load_next_level_scene()-> void:
	set_next_level()
	print("CURRENTLVL:", _current_level)
	#get_tree().change_scene_to_file("res://scenes/levels/level_%s.tscn" % [_current_level])
	clean_and_load_level("res://scenes/levels/level_%s.tscn" % [_current_level])

func clean_and_load_level(new_level_path: String) -> void:
	# First, cleanup the current scene
	var root = get_tree().root
	var current_scene = get_tree().current_scene
	
	# Free all children of the current scene
	if current_scene:
		for child in current_scene.get_children():
			child.queue_free()
		
		# Queue free the current scene itself
		current_scene.queue_free()
	
	# Make sure we process the frame to complete the cleanup
	await get_tree().process_frame
	
	# Load and instance the new scene
	var new_scene = load(new_level_path)
	if new_scene:
		new_scene = new_scene.instantiate()
		get_tree().root.add_child(new_scene)
		get_tree().current_scene = new_scene
	else:
		push_error("Failed to load new scene: " + new_level_path)
		return
		
	# Optional: Force garbage collection
	if Engine.has_singleton("GarbageCollector"):
		Engine.get_singleton("GarbageCollector").collect()


	#get_tree().change_scene_to_packed(_level_scenes[_current_level])
#func _physics_process(delta):
	#if randf_range(0.0, 1000.0) < 3:
		#print("creating")
		#var new_bai = BAIGU.instantiate()
#
		#call_add_child(new_bai)




