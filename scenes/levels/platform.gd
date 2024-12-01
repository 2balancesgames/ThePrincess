extends TileMap
#var width = 128
#var height = 128
#@onready var player = get_parent().get_parent().get_parent().get_child(0)
# Called when the node enters the scene tree for the first time.

#func _ready():
	#print("Player is : ", player.get_name()) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#var tile_pos = local_to_map(player.position)
	#
	#set_cell(0, Vector2i(tile_pos.x-width/2, tile_pos.y-height/2), 0, Vector2(9, 3))
