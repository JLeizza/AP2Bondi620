extends Node

@onready var player : AudioStreamPlayer = $AudioStreamPlayer

func play_music(stream):
	# Si ya está sonando la misma música, no hacer nada
	if player.stream == stream and player.playing:
		return
	
	player.stream = stream
	player.play()
