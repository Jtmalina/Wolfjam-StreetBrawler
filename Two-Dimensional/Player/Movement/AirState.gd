extends State

class_name AirState

@export var ground_state : State
@export var walk_animation = "walk"

func state_process(delta):
	if (character.is_on_floor()):
		next_state = ground_state
		playback.travel(walk_animation)
