extends Node2D

class_name  AutoGenerator
# Called when the node enters the scene tree for the first time.
func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)
	
func call_add_child(child_to_add)->void:
	call_deferred("add_child_deferred", child_to_add)

