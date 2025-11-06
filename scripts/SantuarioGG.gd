extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overlapping = get_overlapping_areas()
	for area in overlapping:
		if area.name == "StopsArea":  # El StopsArea del bondi
			if Input.is_action_just_pressed("stop"):
				activate() 
				queue_free()

func activate():
	var main = get_parent()
	var timers = main.get_node("Timers")
	for timer in timers.get_children():
		timer.stop()
		
	var bondi = get_parent().bondi
	var duracion_parada = (1 * Cte.TIEMPO_RECOGER_PASAJERO) 
	
	bondi.modify_speed(-bondi.speed, duracion_parada)
		
	bondi.heal(Cte.HEALT_SANT_GG)
	
	for timer in timers.get_children():
		timer.start()
