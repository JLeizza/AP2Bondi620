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
	pass

func init_parada():
	pasajeros = pick_random_elements(pasajeros, Cte.MIN_PASAJEROS, Cte.MAX_PASAJEROS)
	for i in range(pasajeros.size()):
		# Instanciar la escena en lugar de crear un Sprite2D
		var pasajero_instance = pasajeros[i].instantiate()
		pasajero_instance.position = posiciones[i].position
		add_child(pasajero_instance)
	cant_pasajeros = pasajeros.size()
	
	if randf() < Cte.ENEMY_SPAWN_CHANCE:
		enemigos = pick_random_elements(enemigos, Cte.MIN_ENEMIGOS, Cte.MAX_ENEMIGOS)
		if enemigos.size() > 0:
			for i in range (enemigos.size()):
				var enemigo_instance = enemigos[i].instantiate()
				enemigo_instance.position = posiciones[i+cant_pasajeros].position
				add_child(enemigo_instance)
		

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
	if enemigos_activos != 0:
		for enemigo in enemigos_activos:
			enemigo.activate()
	return cant_pasajeros
	
	
