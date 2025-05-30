extends State

class_name GroundState

@export var jump_velocity : float = -400.0
@export var air_state : State
@export var jump_animation : String = "jump"
@export var primary_attack_state : State
@export var primary_attack_animation : String = "primary_attack"
@export var secondary_attack_state : State
@export var secondary_attack_animation : String = "secondary_attack"

func state_process(delta):
	if (!character.is_on_floor()):
		next_state = air_state

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
	if (event.is_action_pressed("primary_attack")):
		primary_attack()
	if (event.is_action_pressed("secondary_attack")):
		secondary_attack()
		
func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)
	
func primary_attack():
	next_state = primary_attack_state
	playback.travel(primary_attack_animation)
		
func secondary_attack():
	next_state = secondary_attack_state
	playback.travel(secondary_attack_animation)
