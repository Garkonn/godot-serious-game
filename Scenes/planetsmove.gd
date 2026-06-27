extends Node2D

var planets = []

func _ready() -> void:
	for child in get_children():
		planets.append({
			"node": child,
			"center": child.position,
			"angle": randf_range(0, TAU),
			"speed": randf_range(0.3, 3),
			"radius_x": randf_range(80, 200),  # horizontal
			"radius_y": randf_range(10, 40)    # vertical (small = flat)
		})

func _process(delta: float) -> void:
	for p in planets:
		p.angle += p.speed * delta
		p.node.position = p.center + Vector2(
			cos(p.angle) * p.radius_x,
			sin(p.angle) * p.radius_y
		)
