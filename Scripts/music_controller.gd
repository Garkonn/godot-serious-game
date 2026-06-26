extends Node2D


@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func bgm_play():
	audio_stream_player.stream = preload("res://Assets/Audio/Music/Space Disk - 115 BPM.wav")
	audio_stream_player.play()
