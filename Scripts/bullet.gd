extends RigidBody2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Area hit: ", area.get_parent().name)
	print("Is enemy group: ", area.get_parent().is_in_group("enemy"))
	if area.get_parent().is_in_group("enemy"):
		area.get_parent().die()
		queue_free()
