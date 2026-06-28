extends CanvasLayer

func _ready() -> void:
	get_tree().paused = true  # freezes the game behind the screen

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
