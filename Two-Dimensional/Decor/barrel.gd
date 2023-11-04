extends Node2D

var health

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health > 0:
		$Fixed.show()
		$Destroyed.hide()
	else:
		$Destroyed.show()
		$Fixed.hide()

func take_damage(damageValue):
	health -= damageValue
