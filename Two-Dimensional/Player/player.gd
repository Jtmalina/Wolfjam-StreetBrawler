extends CharacterBody2D
class_name Player

var screen_size # Size of the game window.
@export var speed = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var anim_tree
var anim_state

@export var health = 100
var dead = false

var is_moving_left = false
var is_moving_right = false
var is_jumping = false
var is_attacking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	anim_state = anim_tree.get("parameters/playback")
	pass # Replace with function body.

func flip_right():
	scale.x = 1
	
func flip_left():
	scale.x = -1
	
func _physics_process(delta):
	# Check for Game Over / Death
	if health <= 0:
		$AnimationPlayer.play("dead")
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
		if Input.is_action_pressed("attack1"):
			anim_state.travel("attack1")
		#elif Input.is_action_pressed("attack2"):
			#anim_state.travel("attack2")
		#elif Input.is_action_pressed("special1"):
			#anim_state.travel("special1")	
		#elif Input.is_action_pressed("special2"):
			#anim_state.travel("special2")
		elif Input.is_action_pressed("run"):
			anim_state.travel("run")
		else:
			anim_state.travel("walk")
		if (velocity.x < 0):
			flip_left()
		else:
			flip_right()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if Input.is_action_pressed("attack1"):
			anim_state.travel("attack1")
		#elif Input.is_action_pressed("attack2"):
			#anim_state.travel("attack2")
		#elif Input.is_action_pressed("special1"):
			#anim_state.travel("special1")	
		#elif Input.is_action_pressed("special2"):
			#anim_state.travel("special2")	
		else:
			anim_state.travel("idle")

	move_and_slide()

func _on_hit_box_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
		
func take_damage(damageValue):
	health -= damageValue
	$AnimationPlayer.play("hurt")


func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "attack1"):
		is_attacking = false
	pass # Replace with function body.
