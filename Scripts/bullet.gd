extends RigidBody2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	var body = area.get_parent()
	print("Bullet hit: ", body.name, " | groups: ", body.get_groups())
	if body.is_in_group("enemy"):
		body.die()
		queue_free()
