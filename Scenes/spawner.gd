extends Node2D

# ENEMY SPAWN SPEED VARIABLES
@export var enemy_scene: PackedScene
@export var spawn_interval: float = 3.0
@export var minimum_interval: float = 0.4
@export var speedup_amount: float = 0.075

# ENEMY SPEED VARIABLES PER STAGE
var current_enemy_speed: float = 200.0
@export var disc_node: Node2D
@export var enemy_speed_stage1: float = 160.0
@export var enemy_speed_stage2: float = 200.0
@export var enemy_speed_stage3: float = 260.0


var screen_size: Vector2
var corners: Array
var timer: Timer

# DEFINE CORNERS OF SCREEN AND TIMER
func _ready() -> void:
	screen_size = get_viewport_rect().size
	corners = [
		Vector2(0, 0),                         # top left
		Vector2(screen_size.x, 0),             # top right
		Vector2(0, screen_size.y),             # bottom left
		Vector2(screen_size.x, screen_size.y), # bottom right
	]
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = spawn_interval
	timer.timeout.connect(_spawn_enemy)
	timer.start()
	
	disc_node.stage_reached.connect(_on_stage_reached)

# SPAWN ENEMY AT ONE OF THE FOUR CORNERS RANDOMLY
func _spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	var spawn_point = corners[randi() % corners.size()]
	enemy.global_position = spawn_point
	enemy.speed = current_enemy_speed  # set before adding to scene
	get_tree().get_root().add_child(enemy)

	var new_interval = max(minimum_interval, timer.wait_time - speedup_amount)
	timer.wait_time = new_interval
	print("Next enemy in: ", snapped(new_interval, 0.01), " seconds")

# ON STAGE PROGRESSION, INCREASE ENEMY SPEED TO PRE-DETERMINED AMOUNT
func _on_stage_reached(stage_number: int) -> void:
	if stage_number == 2:
		current_enemy_speed = enemy_speed_stage2
	elif stage_number == 3:
		current_enemy_speed = enemy_speed_stage3
