extends Node2D

func activate():
	AudioManager.play_music(preload("res://sounds/llorona.mp3"))
	
	bajar_luz()

func bajar_luz():
	#bajar la luz, el tween ayuda a animar
	var tween = create_tween()
	tween.tween_property(GameState, "luz", 4, 1.0)
	
	#crea el timer y espera a que termine
	await get_tree().create_timer(12.0).timeout
	
	#animacion para que vuelva la luz a la normalidad
	var tween2 = create_tween()
	tween2.tween_property(GameState, "luz", 3, 1.0)
