extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var music_tracks = [
	preload("res://Assets/Audio/Music/Space Disk - 85 BPM.wav"),
	preload("res://Assets/Audio/Music/Space Disk - 100 BPM.wav"),
	preload("res://Assets/Audio/Music/Space Disk - 115 BPM.wav"),
	preload("res://Assets/Audio/Music/Space Disk - 125 BPM.wav"),
]

@export var starting_track: int = 0 # VARIABLE FOR STATING WHICH SONG TO START WITH (1=100BPM, 2=115BPM, 3=125BPM)

func bgm_play() -> void:
	play_stage_music(starting_track)  # START WITH SLOWEST

func play_stage_music(stage_index: int) -> void:
	var clamped = clamp(stage_index, 0, music_tracks.size() - 1)
	audio_stream_player.stream = music_tracks[clamped]
	audio_stream_player.play()
