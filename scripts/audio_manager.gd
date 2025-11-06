extends Node

@onready var player : AudioStreamPlayer = $AudioStreamPlayer

func play_music(stream):
	#si ya está sonando la misma música no hace nada
	if player.stream == stream and player.playing:
		return
	
	player.stream = stream
	player.play()
	
func restart_music():
	#reiniciar musica
	if player.stream:
		player.stop()
		player.play()
