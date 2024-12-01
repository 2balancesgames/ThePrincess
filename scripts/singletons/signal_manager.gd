extends Node

signal on_enemy_killed(point: int, enemy_position: Vector2)


signal weapons_off()
signal shake_cam()
signal grab_started(player: CharacterBody2D, enemy: CharacterBody2D, buff:int)
signal grab_ended(blast:int)
# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
