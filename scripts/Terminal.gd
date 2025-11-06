extends Area2D

var hud = preload("res://scenes/HUD.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overlapping = get_overlapping_areas()
	for area in overlapping:
		if area.name == "StopsArea":
			if Input.is_action_just_pressed("stop"):
				print("Espacio presionado!") 
				activate()
				condicion()

func condicion():
	if GameState.pasajeros >= 10:
		GameState.emit_signal("ganar_signal")
	else:
		print("Todavía faltan pasajeros: ", 10 - GameState.pasajeros)
		

func activate():	
	var bondi = get_parent().bondi
	var duracion_parada = (Cte.TIEMPO_RECOGER_PASAJERO + 1) 
	
	bondi.modify_speed(-bondi.speed-10, duracion_parada)
