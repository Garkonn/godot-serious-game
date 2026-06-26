extends Node2D

@export var rotation_speed: float = 0.8
var current_speed: float = 0.0

# HAS A TIMER ON START, WHEN TIMER IS COMPLETE, WINDS UP TO FULL SPEED OVER 4 SECONDS:
func _ready() -> void:
	await get_tree().create_timer(1.5).timeout
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "current_speed", rotation_speed, 2.5)
	
# WAITS FOR MAX SPEED, THEN PRINT IN EDITOR:
	await tween.finished
	print("Disc at full speed: ", current_speed)

func _physics_process(delta: float) -> void:
	rotation += current_speed * delta
