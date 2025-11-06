extends Node2D

func activate():
	AudioManager.play_music(preload("res://sounds/pombero.wav"))
	
	var main = get_parent().get_parent()
	var bondi = main.bondi
	
	var veces = randi_range(1, 3)
	for i in veces:
		bondi.modify_speed(Cte.POMBERITO_LOW_SPEED, Cte.POMBERITO_TIMER_LOOP)
		bondi.modify_speed(Cte.POMBERITO_HIGH_SPEED, Cte.POMBERITO_TIMER_LOOP)
