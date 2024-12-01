extends Node



@onready var camera_2d = $Camera2D
@onready var player = $Player
@onready var label = $Camera2D/CanvasLayer/Label
#@onready var static_body_2d = $StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#animationPlayer = get_node("monkeyking/myPlayer")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#animationPlayer.play("run")
	camera_2d.position.x=player.position.x
	#static_body_2d.position.x = player.position.x


 # Replace with function body.


#func _on_button_pressed():
	#pass
	#var pos = Vector2(player.global_position.x + 2000, player.global_position.y)
	#GameManager.generate_jutu(pos) # Replace with function body.
