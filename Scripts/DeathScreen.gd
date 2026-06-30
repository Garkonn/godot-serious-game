extends CanvasLayer

func _ready() -> void:
	get_tree().paused = true
	$VBoxContainer/ScoreLabel.text = "Final Score: " + str(ScoreManager.score)

func _on_restart_button_pressed() -> void:
	ScoreManager.score = 0
	get_tree().paused = false
	get_tree().reload_current_scene()
	queue_free()
