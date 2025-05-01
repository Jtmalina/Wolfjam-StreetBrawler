extends CharacterBody2D
class_name player

@export var speed = 300.0
var direction : Vector2 = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_tree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
var anim_state

@export var health = 100
var dead = false

var is_moving_left = false
var is_moving_right = false
var is_jumping = false
var is_attacking = false
var is_running = false
var is_idle = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_tree.active = true
	anim_state = anim_tree.get("parameters/playback")
	pass # Replace with function body.

func _physics_process(delta):
	# Check for Game Over / Death
	if health <= 0:
		#$AnimationPlayer.play("dead")
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = jump_velocity
		is_jumping = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()
	update_facing_direction()

func _on_hit_box_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
		
func take_damage(damageValue):
	health -= damageValue
	#$AnimationPlayer.play("hurt")

func update_animation():
	anim_tree.set("parameters/Walk/blend_position", direction.x)
			
func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false;
	elif direction.x < 0:
		sprite.flip_h = true;

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "attack1"):
		is_attacking = false
	pass # Replace with function body.
