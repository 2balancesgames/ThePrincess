# TrailEffect.gd - Create this as a new node
extends Node2D
class_name TrailEffect
@export var trail_length := 3
@export var fade_duration := 0.3

var sprite_to_copy: Sprite2D
var trails: Array[Sprite2D] = []
var time_points: Array[float] = []

func _ready():
	# Get the player's sprite
	sprite_to_copy = get_parent().get_node("TrailSprite") 
	set_as_top_level(true)  # Make trail independent of player transform
	
	# Create pool of shadow sprites
	for i in trail_length:
		var shadow = Sprite2D.new()
		shadow.texture = sprite_to_copy.texture
		#shadow.hframes = sprite_to_copy.hframes  # If using sprite sheets
		#shadow.vframes = sprite_to_copy.vframes
		shadow.modulate = Color(1, 1, 1, 0.0)  # Blueish shadow color, starts invisible
		add_child(shadow)
		trails.append(shadow)
		time_points.append(0.0)
	
	stop_trail() # initially not in use 

func _process(delta):
	if !is_instance_valid(sprite_to_copy):
		return
		
	# Update time points
	for i in range(time_points.size()):
		time_points[i] += delta
		
	# Update trail positions and properties
	for i in range(trails.size()):
		var trail = trails[i]
		
		# Copy sprite properties
		trail.frame = sprite_to_copy.frame
		trail.flip_h =  owner.facing_dir == -1
		#trail.flip_v = sprite_to_copy.flip_v
		
		# Calculate fade
		var alpha = 1.0 - (time_points[i] / fade_duration)
		alpha = clamp(alpha, 0.0, 0.8)  # Max 50% opacity
		trail.modulate.a = alpha
		
		if time_points[i] > fade_duration:
			# Reset this trail
			trail.global_position = sprite_to_copy.global_position
			time_points[i] = 0.0
		
	# Sort trails by time for proper layering
	trails.sort_custom(func(a, b): 
		return time_points[trails.find(a)] > time_points[trails.find(b)])

func start_trail():
	# Called when dash starts
	visible = true
	for i in range(trails.size()):
		trails[i].global_position = sprite_to_copy.global_position
		time_points[i] = float(i) * (fade_duration / float(trail_length))

func stop_trail():
	# Called when dash ends
	await get_tree().create_timer(fade_duration).timeout
	visible = false
