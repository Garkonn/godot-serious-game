extends CharacterBody2D

var speed = 420.0
var bullet_speed = 2000
var bullet = preload("res://Scenes/Bullet.tscn")
@export var disc: Node2D

var last_disc_rotation: float = 0.0

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())

func _physics_process(_delta: float) -> void:
	var move_dir = Vector2(Input.get_axis("move_left", "move_right"),
	Input.get_axis("move_up", "move_down"))

	if move_dir != Vector2.ZERO:
		velocity = speed * move_dir.normalized()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
	
		


	if disc:
		var delta_rotation = disc.rotation - last_disc_rotation
		var offset = global_position - disc.global_position
		offset = offset.rotated(delta_rotation)
		global_position = disc.global_position + offset
		last_disc_rotation = disc.rotation
		var disc_radius: float = 500.0  # MUST BE FIXED IF DISC SIZE IS CHANGED
		if offset.length() > disc_radius:
			global_position = disc.global_position + offset.normalized() * disc_radius

	if Input.is_action_just_pressed("shoot"):
		fire()

func fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
