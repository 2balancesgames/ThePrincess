extends CanvasLayer

@onready var label = $Label
@onready var gameover = $Gameover
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode =Node.PROCESS_MODE_ALWAYS
	timer.wait_time = 120 
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str(timer.time_left).pad_decimals(2)

	if gameover.visible == true:
		if Input.is_action_just_pressed("jump") == true:
			GameManager.load_main_scene()


func _on_timer_timeout():
	pass
	#label.text = "Game Over"  
	#gameover.visible=true
	#get_tree().paused= true 
