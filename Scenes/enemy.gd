extends CharacterBody2D

var speed: float = 200.0
var player: Node2D = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func die() -> void:
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Enemy area hit by: ", area.get_parent().name)
	if area.get_parent().is_in_group("bullet"):
		area.get_parent().queue_free()
		die()
	elif area.get_parent().is_in_group("player"):
		area.get_parent().die()
