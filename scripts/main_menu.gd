extends Control

func _ready():
	#autoload para evitar que se repita la introduccion
	print("GameState.intro_mostrada = ", GameState.intro_mostrada)
	#iniciar musica del menu
	AudioManager.play_music(preload("res://music/Fate.wav"))
	
	#funcion de verificar su estado, activarla y desactivarla si corresponde
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
#	#para q el sonido del motor y los grillos arranquen cuando pongo jugar
	AudioManager.play_music(preload("res://music/grillos.wav"))
	AudioManager.play_music(preload("res://music/motor.wav"))

	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://scenes/Menu_options.tscn")


func _on_salir_pressed():
	get_tree().quit()


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
