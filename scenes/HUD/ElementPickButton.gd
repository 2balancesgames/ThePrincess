extends TextureButton
@onready var label = $Label



# Called when the node enters the scene tree for the first time.
func _ready():
	SkillManager.fireElementCard.connect(self.set_text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_text(txt):
	print("called set_text")
	label.text = txt
	

func _on_pressed():
	print("ha") # Replace with function body.
	#SkillManager.increase_base_speed(100)

	GameManager.load_next_level_scene()
