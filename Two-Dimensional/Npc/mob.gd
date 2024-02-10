extends CharacterBody2D
class_name mob

const speed = 300.0
const JUMP_VELOCITY = -400.0
@onready var ai = $AISideScroll
@onready var health = 100
var dead = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var DirectionToMove = 0
var DistanceToMove = 0
var bShouldJump = false

func _ready():
	ai.initialize(self)

func _physics_process(delta):
	# Check for Game Over / Death
	if health <= 0:
		if dead == false:
			$AnimationPlayer.play("dead")
			dead = true
		return
			
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if bShouldJump && is_on_floor():
		#velocity.y = JUMP_VELOCITY
		bShouldJump = false

	if DirectionToMove:
		velocity.x = DirectionToMove.x * speed
		if DistanceToMove <= 75:
			# TODO: Hook up other move, random num?
			$AnimationPlayer.play("attack1")
			#$AnimationPlayer.play("attack2")
			#$AnimationPlayer.play("special1")
			#$AnimationPlayer.play("special2")
			
			#TODO: HOok up run logic
			#$AnimationPlayer.play("run")
		else:
			$AnimationPlayer.play("walk")
		if (velocity.x < 0):
			flip_left()
		else:
			flip_right()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if DistanceToMove <= 75:
			# TODO: Hook up other move, random num?
			$AnimationPlayer.play("attack1")
			#$AnimationPlayer.play("attack2")
			#$AnimationPlayer.play("special1")
			#$AnimationPlayer.play("special2")
		else:
			$AnimationPlayer.play("idle")

	move_and_slide()
	
func flip_right():
	scale.x = 1
	
func flip_left():
	scale.x = -1

func process_detection(_directionToMove, _distanceToMove):
	DirectionToMove = _directionToMove
	if DistanceToMove == _distanceToMove:
		bShouldJump = true
	DistanceToMove = _distanceToMove
	
func take_damage(damageValue):
	health -= damageValue
	$AnimationPlayer.play("hurt")

func _on_hit_box_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
