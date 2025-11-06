extends Area2D

var pasajeros
var enemigos
var posiciones

var enemigos_activos
var cant_pasajeros


# Called when the node enters the scene tree for the first time.
func _ready():
	init_variables()
	init_parada()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overlapping = get_overlapping_areas()
	for area in overlapping:
#		print("Área detectada: ", area.name)  # Debug
		if area.name == "StopsArea":
#			print("StopsArea detectada!")  # Debug
			if Input.is_action_just_pressed("stop"):
#				print("Espacio presionado!")  # Debug
				activate()

func init_parada():
	pasajeros = pick_random_elements(pasajeros, Cte.MIN_PASAJEROS, Cte.MAX_PASAJEROS)
	var pasajeros_instancias = []
	
	for i in range(pasajeros.size()):
		# Instanciar la escena en lugar de crear un Sprite2D
		var pasajero_instance = pasajeros[i].instantiate()
		pasajero_instance.position = posiciones[i].position
		add_child(pasajero_instance)
		pasajeros_instancias.append(pasajero_instance)
	pasajeros = pasajeros_instancias
	cant_pasajeros = pasajeros.size()
	
	enemigos_activos = []
	
	if randf() < Cte.ENEMY_SPAWN_CHANCE:
		enemigos = pick_random_elements(enemigos, Cte.MIN_ENEMIGOS, Cte.MAX_ENEMIGOS)
		if enemigos.size() > 0:
			for i in range (enemigos.size()):
				var enemigo_instance = enemigos[i].instantiate()
				enemigo_instance.position = posiciones[i+cant_pasajeros].position
				add_child(enemigo_instance)
				enemigos_activos.append(enemigo_instance)
		

func pick_random_elements(array, min, max):
	var count = randi_range(min, max)
	var shuffled = array.duplicate()
	shuffled.shuffle()
	return shuffled.slice(0, count)

func init_variables():
	pasajeros = [
	preload("res://scenes/pasajera_1.tscn"),
	preload("res://scenes/pasajera_2.tscn"),
	preload("res://scenes/pasajero_1.tscn"),
	preload("res://scenes/pasajero_2.tscn"),
	preload("res://scenes/pasajero_borracho.tscn") 
	]
	
	enemigos = [
		preload("res://scenes/Pomberito.tscn"),
		preload("res://scenes/Llorona.tscn")
	]

	posiciones = [
		$PosicionesMarkers/Posicion1,
		$PosicionesMarkers/Posicion2,
		$PosicionesMarkers/Posicion3,
		$PosicionesMarkers/Posicion4
	]

func activate():
	
	var main = get_parent()
	var timers = main.get_node("Timers")
	for timer in timers.get_children():
		timer.stop()
	
	var bondi = get_parent().bondi
	var duracion_parada = (cant_pasajeros * Cte.TIEMPO_RECOGER_PASAJERO + 1) 
	
	bondi.modify_speed(-bondi.speed, duracion_parada)
	
	for i in range(pasajeros.size()):
		await get_tree().create_timer(Cte.TIEMPO_RECOGER_PASAJERO).timeout
		pasajeros[i].hide()
		get_parent().agregar_pasajeros()
		print("Pasajero ", i+1, " subió") 
	
	if enemigos_activos.size() > 0:
		for enemigo in enemigos_activos:
			enemigo.activate()
			enemigo.hide()
	
	for timer in timers.get_children():
		timer.start()
	
