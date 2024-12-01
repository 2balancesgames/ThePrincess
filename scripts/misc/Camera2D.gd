extends Camera2D
@onready var shake_timer = $ShakeTimer

const AMOUNT: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.shake_cam.connect(on_shake_cam) # Replace with function body.



func on_shake_cam():
	set_process(true)
	shake_timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



