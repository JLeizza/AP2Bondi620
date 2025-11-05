extends Control


func _ready():
	#detener la musica del juego
	AudioManager.get_node("SonidoMotor").stop()
	AudioManager.get_node("SonidoGrillos").stop()
	#iniciar musica del menu
	AudioManager.get_node("SonidoMenu").play()

func _process(delta):
	pass


func _on_jugar_pressed():
	#Para que se detenga la musica del menu
	AudioManager.get_node("SonidoMenu").stop()
	#para q el sonido del motor y los grillos arranquen cuando pongo play
	AudioManager.get_node("SonidoMotor").play()
	AudioManager.get_node("SonidoGrillos").play()
	
	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://scenes/Menu_options.tscn")


func _on_salir_pressed():
	get_tree().quit()
