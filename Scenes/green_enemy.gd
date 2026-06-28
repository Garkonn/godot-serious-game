extends CharacterBody2D

@onready var player = get_node ("/root/World/Player")

var entered : bool
var speed : int = 100
var direction : Vector2

func _ready():
	var screen_rect =  get_viewport_rect()
	entered = false
	var dist = screen_rect.get_center() - position
	if abs(dist.x) > abs(dist.y):
		direction.x = dist.x
		direction.y = 0
	else:
		direction.x = 0
		direction.y = dist.y
		
func _physics_process(_delta):
	if entered:
		direction = (player.position - position)
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

func _on_entrance_timer_timeout() -> void:
	entered = true
	
