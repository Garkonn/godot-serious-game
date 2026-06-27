extends Node2D

@onready var main = get_node ("res://Scenes/world.tscn")

var GreenEnemy_scene := preload ("res://Scenes/GreenEnemy.tscn")
var spawn_points := []

func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

func _on_timer_timeout():
#pick random spawn point
	var spawn = spawn_points[randi() % spawn_points.size()]
#spawn enemy
	var GreenEnemy = GreenEnemy_scene.instantiate()
	GreenEnemy.position = spawn.position
	main.add_child(GreenEnemy)
