extends CharacterBody2D

var death_screen = preload("res://Scenes/DeathScreen.tscn")
var speed = 420.0
var bullet_speed = 2000
var bullet = preload("res://Scenes/Bullet.tscn")
@export var disc: Node2D
@export var disc_radius: float = 570.0  # MUST BE FIXED IF DISC SIZE IS CHANGED
@export var disc_inner_radius: float = 70.0 # ^^^

var last_disc_rotation: float = 0.0


# NOT USING THIS PROCESS, CAN DELETE
func _process(_delta: float) -> void:
	pass

# SIMPLE MOVE SYSTEM
func _physics_process(_delta: float) -> void:
	var move_dir = Vector2(Input.get_axis("move_left", "move_right"),
	Input.get_axis("move_up", "move_down"))

	if move_dir != Vector2.ZERO:
		velocity = speed * move_dir.normalized()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()


# ROTATE DISC AS WELL AS PLAYER EACH FRAME
	if disc:
		var delta_rotation = disc.rotation - last_disc_rotation
		var offset = global_position - disc.global_position
		offset = offset.rotated(delta_rotation)
		global_position = disc.global_position + offset
		last_disc_rotation = disc.rotation

# RESTRICT PLAYER MOVEMENT TO INSIDE THE DISC
	if disc:
		var offset = global_position - disc.global_position
		var distance = offset.length()
		
		if distance > disc_radius:
			# too far out — push to outer edge
			global_position = disc.global_position + offset.normalized() * disc_radius
		elif distance < disc_inner_radius:
			# too far in — push to inner edge
			global_position = disc.global_position + offset.normalized() * disc_inner_radius


# SHOOT
	if Input.is_action_just_pressed("shoot"):
		fire()

func fire() -> void:
	var gun = $Body/GunPivot
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = $Body/GunPivot/Gun.get_global_position()
	bullet_instance.rotation_degrees = gun.rotation_degrees
	bullet_instance.apply_impulse(Vector2(bullet_speed, 0).rotated(gun.rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	
# DIE


func die() -> void:
	var screen = death_screen.instantiate()
	get_tree().get_root().add_child(screen)
	queue_free()
