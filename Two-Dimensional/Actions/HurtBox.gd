class_name HurtBox
extends Area2D

func _init():
	collision_layer = 0
	collision_mask = 2
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# Called when a Area2D enters this HurtBox. Only HitBox type will be accepted
func _on_area_entered(hitbox: HitBox):
	if hitbox == null:
		return
	
	# Owner of this scene = root node (Your character or NPC Char)
	# If the root node has a take_damage method, call it with the damage value
	# we can then access this damage value in the root node and use as needed
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
