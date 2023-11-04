extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Get a list of available animations
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	# Pick a random one with index between 0-2 (randi() % n = random int between 0 and n-1)
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
