extends CharacterBody2D
class_name mob

# character traits
const speed = 300.0
const JUMP_VELOCITY = -400.0
@onready var ai = $AISideScroll
@onready var health = 100
var dead = false

# animation
@onready var anim_tree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : AiStateMachine = $AiStateMachine
var anim_state

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var directionToMove : Vector2 = Vector2.ZERO
var distanceToMove : float = 0
var bShouldJump = false
var aiInput : AiMovementInput = AiMovementInput.WALK

enum AiMovementInput{
	WALK,
	RUN,
	JUMP,
	ATTACK
}

func _ready():
	ai.initialize(self)
	anim_tree.active = true
	anim_state = anim_tree.get("parameters/playback")

func _physics_process(delta):
	# Check for Game Over / Death
	#if health <= 0:
		#if dead == false:
			#$AnimationPlayer.play("dead")
			#dead = true
		#return
			
		
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if directionToMove.x != 0 && state_machine.check_if_can_move():
		velocity.x = directionToMove.x * speed
		if distanceToMove <= 75:
			# TODO: Hook up other move, random num?
			aiInput = AiMovementInput.ATTACK
			pass
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if distanceToMove <= 75:
			# TODO: Hook up other move, random num?
			aiInput = AiMovementInput.ATTACK
			pass

	# Handle Jump
	if bShouldJump:
		aiInput = AiMovementInput.JUMP
		bShouldJump = false;
		
	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	state_machine.process_ai_movement(aiInput)
	
func update_facing_direction():
	if directionToMove.x > 0:
		sprite.flip_h = false;
	elif directionToMove.x < 0:
		sprite.flip_h = true;

func process_detection(_directionToMove : Vector2, _distanceToMove : float):
	directionToMove = _directionToMove
	if distanceToMove == _distanceToMove:
		bShouldJump = true
	distanceToMove = _distanceToMove
	
func take_damage(damageValue):
	health -= damageValue
	#$AnimationPlayer.play("hurt")

func update_animation_parameters():
	anim_tree.set("parameters/Walk/blend_position", directionToMove.x)

func _on_hit_box_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
