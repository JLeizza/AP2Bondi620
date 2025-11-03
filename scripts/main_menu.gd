extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	# para que arranque la música cuando le das play al juego
	AudioManager.get_node("MusicaDeFondo").play()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_jugar_pressed():
	
	var bus_index = AudioServer.get_bus_index("FX_Ambiental")
	AudioServer.set_bus_volume_db(bus_index, 0.0)
	
	# para q el sonido del motor y los grillos arranquen cuando pongo play
	AudioManager.get_node("SonidoMotor").play()
	AudioManager.get_node("SonidoGrillos").play()
	
	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_opciones_pressed():
	print("Proximamente crack, pedis mucho")


func _on_salir_pressed():
	get_tree().quit()
