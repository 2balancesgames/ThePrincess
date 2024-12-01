extends Node
# Base interface for a generic state machine.
# It handles initializing, setting the machine active or not
# delegating _physics_process, _input calls to the State nodes,
# and changing the current/active state.
class_name StateMachine

signal entering_new_state(state)
signal entered_new_state(state)
signal state_changed(current_state)

# You should set a starting node from the inspector or on the node that inherits
# from this state machine interface. If you don't, the game will default to
# the first state in the state machine's children.
@export var start_state: NodePath
var states_map = {}

var current_state = null
var _active = false:
	set(value): #setter
		_active = value
		set_physics_process(_active)
		set_process_input(_active)
		if not _active:
			current_state = null

func _enter_tree():
	assert(!start_state.is_empty())
		
		#start_state = get_child(0).get_path()
		
	# each child is a state
	# once child finished, callback the _change_state here 
	for child in get_children():
		var err = child.imDoneNow.connect(self._change_state)
		if err:
			printerr(err)
		else:
			states_map[child.get_name().to_lower()] = child
			
	_active = true
	current_state = get_node(start_state)
	print("Current_state: "+ current_state.get_name())
	current_state.enter()


				#func _unhandled_input(event):
	#current_state.handle_input(event)


func _physics_process(delta):
	if owner.is_physics_processing():
		current_state.update(delta)
	


func _on_animation_finished(anim_name):
	#if not _active:
		#return
	current_state._on_animation_finished(anim_name)


func _change_state(next_state):
	if not _active or current_state.final:
		return 
	current_state.exit()
	current_state = states_map[next_state]
	emit_signal("state_changed", current_state)
	current_state.enter()


func request_change_state(next_state, ignore_hold= false, re_enter = false) -> bool:
	# combo
	if next_state == "fight" and current_state.get_name() == "fight":
		current_state.combo_queued = true
		return true
		
	if current_state.final or (not ignore_hold and current_state.hold_on) :
		return false
	if not re_enter:
		if current_state.get_name().to_lower() == next_state:
			return true # directly return
	_change_state(next_state)
	return true

		
