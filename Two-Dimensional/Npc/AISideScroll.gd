extends Node2D

signal state_changed(new_state)

@onready var player_detection_zone = $PlayerDetectionZone

var player = null
var actor = null

enum AiState{
	PATROL,
	ENGAGE
}

var CurrentState = AiState.PATROL : set = _set_state

func _set_state(new_State: int):
	if new_State == CurrentState:
		return
	
	CurrentState = new_State
	emit_signal("state_changed", CurrentState)	

func _process(delta):
	match CurrentState:
		AiState.PATROL:
			pass
		AiState.ENGAGE:
			if player != null:
				pass
			else:
				print("In Engage state but player not valid")
		_:
			print("Error: Found an invalid enemy state")	

func _on_player_detection_zone_body_entered(body):
	if (body.is_in_group("player")):
		_set_state(AiState.ENGAGE)
		player = body

func initialize(actor): # can add a weapon: Weapon type if we go modular
	self.actor = actor
