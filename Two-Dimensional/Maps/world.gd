extends Node

var player_instance = preload("res://wizard.tscn").instantiate()
const zombiepath = preload("res://Npc/zombie.tscn")

var spawn_position

# Do I need this? 
@export var zombie : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_position = get_node("PlayerSpawnPoint/PlayerSpawn").global_position
	player_instance.position = spawn_position
	add_child(player_instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
