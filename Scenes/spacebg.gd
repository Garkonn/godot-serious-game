extends TextureRect

@export var scroll_speed: Vector2 = Vector2(0.0, 0.05)
var offset: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	offset += scroll_speed * delta
	material.set_shader_parameter("offset", offset)
