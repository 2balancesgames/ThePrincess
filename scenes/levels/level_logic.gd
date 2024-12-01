extends AutoGenerator

@onready var camera_2d = $Camera2D
@onready var player = $Player
@onready var label = $Camera2D/CanvasLayer/Label
@onready var left_wall = $LeftWall



const platform_pos = 9800
var last_world_pos = 0

const LEFT_WALL_MAX_DIST = 22000
const LEFT_WALL_MIN_CAM_DIST =9800
const WINNING_BOUNDARY = platform_pos * 4 
const RIGHT_WALL_MAX_CAM_DIST = WINNING_BOUNDARY + 4700
const LEFT_WALL_TO_BOUNDARY = 9000

const BAIGUWORLD = preload("res://scenes/terrains/BaiguTerrain.tscn")
const JUTUWORLD = preload("res://scenes/terrains/JutuTerrain.tscn")
const RIGHT_WALL_WORLD = preload("res://scenes/terrains/right_wall.tscn")



const WORLDS = [
	BAIGUWORLD, 
	#JUTUWORLD,
	]

func generate_next_world(global_pos):
	var new_world = WORLDS.pick_random().instantiate()
	new_world.global_position = global_pos
	call_add_child(new_world)

# Called when the node enters the scene tree for the first time.
func _ready():
	player.get_controlled()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# moving the left wall along with the player
	if player.position.x - left_wall.position.x > LEFT_WALL_MAX_DIST:
		left_wall.position.x = player.position.x - LEFT_WALL_MAX_DIST
	
	# cannot go too left
	camera_2d.position.x= clamp(player.position.x, left_wall.position.x+ LEFT_WALL_MIN_CAM_DIST, RIGHT_WALL_MAX_CAM_DIST)

	# cannot go too right
		


func _physics_process(delta):

	var world_next_pos_x = floor(camera_2d.position.x  / platform_pos  + 0.5) * platform_pos
	
	if (world_next_pos_x - last_world_pos >1 ): # because it's not precise 
		#print(last_world_pos, " vs ", world_next_pos_x)
		last_world_pos = world_next_pos_x
		var generating_at = Vector2(world_next_pos_x, 1580)
		if world_next_pos_x >= WINNING_BOUNDARY:
			var finishing_world = RIGHT_WALL_WORLD.instantiate()
			finishing_world.global_position = generating_at
			call_add_child(finishing_world)
		else:
			generate_next_world(generating_at)
	
	# falling through...
	if player.position.y > 2000:
		print("too low")
		player.velocity.x = 0
		player.position.y= -8000
		player.position.x -= 3000
		if player.position.x - left_wall.position.x < LEFT_WALL_TO_BOUNDARY:
			player.position.x = last_world_pos

func _on_cleaning_zone_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	body.queue_free()
