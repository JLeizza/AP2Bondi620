extends Control

func _ready():
	print("GameState.intro_mostrada = ", GameState.intro_mostrada)
	#detener la musica del juego
	AudioManager.get_node("SonidoMotor").stop()
	AudioManager.get_node("SonidoGrillos").stop()
	#iniciar musica del menu
	AudioManager.get_node("SonidoMenu").play()
	
	if GameState.intro_mostrada == false:
		$Negro/AnimationPlayer.play("Fade")
		GameState.intro_mostrada = true
		print("GameState.intro_mostrada = ", GameState.intro_mostrada)
	else:
		$Negro.modulate.a = 0.0
		$Negro/juegopor.modulate.a = 0.0
		$Negro/julen.modulate.a = 0.0
		$Negro/stefa.modulate.a = 0.0
		$Negro/agos.modulate.a = 0.0
		$Negro/khy.modulate.a = 0.0

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


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
