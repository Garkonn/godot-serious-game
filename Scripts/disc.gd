extends Node2D

@export var rotation_speed: float = 0.8
@export var music_controller: Node2D
var current_speed: float = 0.0

# EACH STAGE IS [TARGET SPEED , SECONDS BEFORE THIS STAGE STARTS]
var stages = [
	[0.8, 0.0],
	[1.6, 35.75], # 156
	[2.2, 135.0]
]

# HAS A TIMER ON START, WHEN TIMER IS COMPLETE, WINDS UP TO FULL SPEED OVER 4 SECONDS:
func _ready() -> void:
	await get_tree().create_timer(1.5).timeout
	var stage_number = 0
	for stage in stages:
		var target = stage[0]
		var wait = stage[1]
		
		
		if wait > 0.0:
			# PRINT SECONDS UNTIL NEXT STAGE EVERY 5 SECONDS
			var elapsed = 0.0
			while elapsed < wait:
				var remaining = wait - elapsed
				print("Next stage in: ", snapped(remaining, 0.1), " seconds")
				await get_tree().create_timer(min(5.0, remaining)).timeout
				elapsed += 5.0
			
		stage_number += 1
		print(" Stage ", stage_number, " reached! Ramping to speed: ", target)
		music_controller.play_stage_music(music_controller.starting_track + stage_number)
			
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		tween.tween_property(self, "current_speed", target, 2.5)
		await tween.finished
	print("Disc at full speed: ", current_speed)



func _physics_process(delta: float) -> void:
	rotation += current_speed * delta
