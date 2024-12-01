extends Node
# Base interface for all states: it doesn't do anything by itself,
# but forces us to pass the right arguments to the methods below
# and makes sure every State object had all of these methods.

# tell the state_machine to change_state(next_state_name)
# warning-ignore:unused_signal
signal imDoneNow(next_state_name) 
var hold_on: bool = false # at current state, no external request can change the state
var final: bool = false # neither external nor internal request can change can change the state anymore

# Initialize the state. E.g. change the animation.
func enter():
	pass


# Clean up the state. Reinitialize values like a timer.
func exit():
	pass


func handle_input(_event):
	pass


func update(_delta):
	pass


func _on_animation_finished(_anim_name):
	pass
	

