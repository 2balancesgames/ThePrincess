extends "res://scripts/state_machine/state.gd"

	

func enter():
	hold_on=true
	owner.velocity.x = owner.SPEED * owner.facing_dir * owner.ATTACK_FACTOR 
	owner.get_node(^"AnimationPlayer").play("fight_1")


# called at the end of the fight animation
func request_to_hold_player():
	if owner.get_node(^"holdZone").is_colliding(): # at this moment, the player is definitely held.
		owner.invincible = true # so anything should not kill this guy now
		if InteractionManager.can_grab(owner, owner.player_ref, 1000):
			InteractionManager.initiate_grab(owner, owner.player_ref)
			SignalManager.grab_ended.connect(owner.shock_wave)
			SignalManager.grab_ended.connect(owner.shock_wave) # until blast
	else:
		emit_signal("imDoneNow","idle")
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func update(delta):
	#PhysicsUtils.apply_gravity(owner, delta)
	#owner.move_and_slide()
	#

