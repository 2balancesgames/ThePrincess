extends Node2D
@onready var camera_2d = $"../Camera2D"
@onready var player = $"../Player"

@onready var far = $far
@onready var mid = $mid
@onready var near = $near
@onready var far2 = $far2
@onready var mid2 = $mid2
@onready var near2 = $near2

var far_length = 9600
var mid_length = 8000
var near_length = 9500

var far_pos = 0
var far2_pos = far_length
var mid_pos = 0
var mid2_pos = mid_length
var near_pos = 0
var near2_pos = near_length

var far_effect = 0.7
var mid_effect = 0.5
var near_effect = 0.1


func _physics_process(delta):
	var cam_x = camera_2d.position.x
	far.position.x = far_pos + cam_x * far_effect
	far2.position.x = far2_pos + cam_x * far_effect
	mid.position.x = mid_pos + cam_x * mid_effect
	mid2.position.x = mid2_pos + cam_x * mid_effect
	near.position.x = near_pos + cam_x * near_effect
	near2.position.x = near2_pos + cam_x * near_effect
	
	var near_diff = cam_x * (1-near_effect) - near_length
	var mid_diff = cam_x * (1-mid_effect) - mid_length
	var far_diff = cam_x * (1-far_effect) - far_length
	if  near_diff  >  near_pos:
		near_pos += 2 * near_length
	if near_diff > near2_pos :
		near2_pos += 2 * near_length
	if  mid_diff  >  mid_pos:
		mid_pos += 2 * mid_length
	if  mid_diff  >  mid2_pos:
		mid2_pos += 2 * mid_length
	if  far_diff  >  far_pos:
		far_pos += 2 * far_length
	if  far_diff  >  far2_pos:
		far2_pos += 2 * far_length
