extends AutoGenerator
class_name Spawner

@onready var timer = Timer.new()
var TARGET = "the target thing to generate"
var WAIT_TIME = 5
var PRELOADED = null
var X_OFFSET= -100
var Y_OFFSET= -200
var BEGIN_WITH_ONE = true

func _ready():
	add_child(timer)
	if BEGIN_WITH_ONE:
		generate()
	# Connect the timer's timeout signal to the _on_timer_timeout method
	timer.connect("timeout", self._on_timer_timeout)
	timer.wait_time =  WAIT_TIME
	timer.start()


func _on_timer_timeout():
	# This method will be called every 20 seconds
	# print(TARGET, " spawners Timer timeout!")
	generate()
	timer.start()

func generate():
	var to_generate = PRELOADED.instantiate()
	# TODO: generate to the left when the player is on the left, and right when it's on the right
	to_generate.global_position = global_position + Vector2(-100, Y_OFFSET)
	call_add_child(to_generate)
	timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
