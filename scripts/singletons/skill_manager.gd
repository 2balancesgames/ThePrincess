extends Node

var base_speed = 300

# Fire Cards:
var fire_cards = {
	"increase_base_speed": [100],
	"increase_dash_speed": [30],
	"decrease_dash_cool_down": [10]
}

var fire_skill_selected_name: String
var fire_skill_selected_args: Array

signal fireElementCard(desp)

func fire_skill_selected()->void:
	callv(fire_skill_selected_name, fire_skill_selected_args)

func assign_skill_cards():
	fire_skill_selected_name  = fire_cards.keys().pick_random()
	emit_signal("fireElementCard", fire_skill_selected_name)

func increase_base_speed(amt):
	base_speed += amt
	print("Speed increased ", amt, " now: ", base_speed)

func increase_dash_speed(amt):
	print("Dash speed increased")

func decrease_dash_cool_down(amt):
	print("dash cool down decreased")
