extends Area2D

var pasajeros
var enemigos
var posiciones


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
		var sprite = Sprite2D.new()
		sprite.texture = pasajeros[i]
		sprite.position = posiciones[i].position
		add_child(sprite)

func pick_random_elements(array, min, max):
	var count = randi_range(min, max)
	var shuffled = array.duplicate()
	shuffled.shuffle()
	return shuffled.slice(0, count)

func init_variables():
	pasajeros = [
	preload("res://sprites/FemPass1.png"),
	preload("res://sprites/FemPass2.png"),
	preload("res://sprites/Fisura 1.png"),
	preload("res://sprites/MalePass1.png"),
	preload("res://sprites/MalePass2.png") 
	]
	
	enemigos = [
		preload("res://scenes/Pomberito.tscn"),
		preload("res://scenes/Llorona.tscn")
	]

	posiciones = [
		$PosicionesMarkers/Posicion1,
		$PosicionesMarkers/Posicion2,
		$PosicionesMarkers/Posicion3
	]
	
