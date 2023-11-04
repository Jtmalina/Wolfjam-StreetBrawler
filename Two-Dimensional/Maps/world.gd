extends Node

@export var playerpath = NodePath()
@onready var wizard = get_node(playerpath)

const zombiepath = preload("res://Npc/zombie.tscn")
@export var zombie : PackedScene

@onready var pathfollow2d = wizard.get("path_follow_2d")
@onready var spawn_point = wizard.get("spawn_point")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
