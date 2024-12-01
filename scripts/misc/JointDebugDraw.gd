# JointDebugDraw.gd
extends Node2D

class_name JointDebugDraw
@export var line_color: Color = Color.YELLOW
@export var line_width: float = 2.0
@export var draw_anchor_points: bool = true
@export var anchor_radius: float = 5.0

func _ready():
	# Ensure this node updates even when the game is paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	# Make sure we draw on top of other nodes
	z_index = 100
	# Set this to see the visualization through other nodes
	top_level = true

func _draw():
	var joint = get_parent() as PinJoint2D
	if not joint:
		return
		
	var node_a = get_node(joint.node_a)
	var node_b = get_node(joint.node_b)
	
	if not (node_a and node_b):
		return
	
	# Draw line between connected nodes
	var start_pos = node_a.global_position
	var end_pos = node_b.global_position
	draw_line(start_pos, end_pos, line_color, line_width)
	
	if draw_anchor_points:
		# Draw circles at anchor points
		draw_circle(start_pos, anchor_radius, line_color)
		draw_circle(end_pos, anchor_radius, line_color)

func _process(_delta):
	# Continuously update the visualization
	queue_redraw()
