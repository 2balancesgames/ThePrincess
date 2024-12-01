extends AutoGenerator

const BAIGU_SPAWNER = preload("res://scenes/terrains/spawners/BaiguSpawner.tscn")

func _ready():
	var new_spawner = BAIGU_SPAWNER.instantiate()
	new_spawner.global_position = global_position + Vector2(3000, -100)
	call_add_child(new_spawner)	



