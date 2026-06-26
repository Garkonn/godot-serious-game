extends CharacterBody2D

var speed = 420.0
var bullet_speed = 2000
var bullet = preload("res://Scenes/Bullet.tscn")
@export var disc: Node2D

var last_disc_rotation: float = 0.0

# NOT USING THIS PROCESS, CAN DELETE
func _process(_delta: float) -> void:
	pass

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

	if Input.is_action_just_pressed("shoot"):
		fire()

func fire() -> void:
	var gun = $Body/GunPivot
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = gun.get_global_position()
	bullet_instance.rotation_degrees = gun.rotation_degrees
	bullet_instance.apply_impulse(Vector2(bullet_speed, 0).rotated(gun.rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
