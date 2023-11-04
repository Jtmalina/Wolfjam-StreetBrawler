extends CharacterBody2D
class_name Player

var screen_size # Size of the game window.
@export var speed = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pass # Replace with function body.

func flip_right():
	$Sprite2D.flip_h = false
	
func flip_left():
	$Sprite2D.flip_h = true

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
			$AnimationPlayer.play("attack1")
		elif Input.is_action_pressed("attack2"):
			$AnimationPlayer.play("attack2")
		elif Input.is_action_pressed("flame"):
			$AnimationPlayer.play("flame")	
		elif Input.is_action_pressed("fireball"):
			$AnimationPlayer.play("fireball")	
		elif Input.is_action_pressed("run"):
			$AnimationPlayer.play("run")
		else:
			$AnimationPlayer.play("walk")
		if (velocity.x < 0):
			flip_left()
		else:
			flip_right()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if Input.is_action_pressed("attack1"):
			$AnimationPlayer.play("attack1")
		elif Input.is_action_pressed("attack2"):
			$AnimationPlayer.play("attack2")
		elif Input.is_action_pressed("flame"):
			$AnimationPlayer.play("flame")	
		elif Input.is_action_pressed("fireball"):
			$AnimationPlayer.play("fireball")	
		else:
			$AnimationPlayer.play("idle")

	move_and_slide()

func _on_sword_hit_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
		
func take_damage(damage):
	health -= damage
