extends "res://scripts/state_machine/state.gd"

# combo is like a substate. the fight state can be at one of these substates.
var combo_queued = false

var combo = [{
	"damage": 1,
	"animation": "fight_1",
	"shift": 100,
	"effect": null
},{
	"damage": 2,
	"animation": "fight_2",
	"shift": -100,
	"effect": null
},
{
	"damage": 3,
	"animation": "fight_3",
	"shift": 0,
	"effect": null
}]

const COMBO_WINDOW_MSEC = 700
var last_time_fought = -COMBO_WINDOW_MSEC
var combo_idx = 0
 

func enter():
	#print("combo_idx", combo_idx)
	# set the substate
	if last_time_fought + COMBO_WINDOW_MSEC < Time.get_ticks_msec():
		#print("new enter")
		combo_idx = 0 
	else:
		print("combo")
		combo_idx = (combo_idx + 1) % len(combo)
	owner.velocity.x = combo[combo_idx]["shift"] * owner.facing_dir
	owner.get_node(^"AnimationPlayer").play(combo[combo_idx]['animation']) 

# let the animations call this
func back_to_idle():
	last_time_fought = Time.get_ticks_msec()
	if not combo_queued:
		emit_signal("imDoneNow","idle")
		return
	combo_queued = false
	enter()
	

