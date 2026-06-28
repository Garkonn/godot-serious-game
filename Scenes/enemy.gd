extends CharacterBody2D

var speed: float = 200.0
var player: Node2D = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	$Area2D.body_entered.connect(_on_area_2d_body_entered)

func _physics_process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func die() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node) -> void:
	print("Enemy touched by: ", body.name)
	if body.is_in_group("bullet"):
		body.queue_free()
		die()
	elif body.is_in_group("player"):
		body.die()
