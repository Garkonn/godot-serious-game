extends CharacterBody2D

var speed: float = 1000.0
var player: Node2D = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func die() -> void:
	ScoreManager.add_score(1)
	queue_free()

func _on_area_2d_body_entered(body: Node) -> void:
	print("Enemy touched: ", body.name, " | groups: ", body.get_groups())
	if body.is_in_group("player"):
		body.die()
