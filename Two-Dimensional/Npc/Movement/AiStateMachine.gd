extends Node
class_name AiStateMachine

@export var current_state : State
@export var animation_tree : AnimationTree
@export var character : CharacterBody2D

var states : Array[State]

func _ready() -> void:
	for child in get_children():
		if(child is State):
			states.append(child)
			
			#invitialize the states with anything they may need to function here
			child.character = character
			child.playback = animation_tree["parameters/playback"]
		else:
			push_warning("Child " + child.name + " is not a state for CharacterStateMachine")

func _physics_process(delta: float) -> void:
	if (current_state.next_state != null):
		switch_states(current_state.next_state)
		
	## current_state.playback.travel(death_animation)
	current_state.state_process(delta)

func check_if_can_move():
	return current_state.can_move

func switch_states(new_state : State):
	if (current_state != null):
		current_state.on_enter()
		current_state.next_state = null
	# can do stuff here before a state needs to end
	current_state = new_state
	current_state.on_exit()
	
# Tracks input and sends it to the current state to handle 
func _input(event : InputEvent):
	current_state.state_input(event)
	
func process_ai_movement(aiInput : mob.AiMovementInput):
	current_state.ai_movement_process(aiInput)
