extends Node2D

@export var rotation_speed: float = 1 

var player: CharacterBody2D = null

func _process(delta: float) -> void:
	var delta_rotation = rotation_speed * delta
	rotation += delta_rotation

	if player:

		var offset = player.global_position - global_position
		offset = offset.rotated(delta_rotation)
		player.global_position = global_position + offset


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
