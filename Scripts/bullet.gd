extends RigidBody2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	print("Area hit: ", parent.name, " groups: ", parent.get_groups())
	if parent.is_in_group("enemy"):
		parent.die()
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Area hit: ", body.get_parent().name)
	print("Is enemy group: ", body.get_parent().is_in_group("enemy"))
	if body.get_parent().is_in_group("enemy"):
		body.get_parent().die()
		queue_free()
