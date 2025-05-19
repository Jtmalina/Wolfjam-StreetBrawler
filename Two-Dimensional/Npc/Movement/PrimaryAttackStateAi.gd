extends State

class_name PrimaryAttackStateAi

@export var primary_attack : String = "primary_attack"
@export var secondary_attack : String = "secondary_attack"
@export var walk_animation : String = "Walk"
@export var return_state : State

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == primary_attack || anim_name == secondary_attack):
		next_state = return_state
		playback.travel(walk_animation)
	
func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass
