extends State

class_name GroundStateAi

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

func ai_movement_process(aiInput : mob.AiMovementInput):
	if (aiInput == mob.AiMovementInput.JUMP):
		jump()
	if (aiInput == mob.AiMovementInput.ATTACK):
		primary_attack()
		
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
