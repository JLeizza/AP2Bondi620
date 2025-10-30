extends Node

#Carga de obstaculos
var basura_scene =preload("res://scenes/Basura.tscn")
var cascote_scene =preload("res://scenes/Cascote.tscn")
var gomas_scene =preload("res://scenes/Gomas.tscn")
var santuario_gauchito =preload("res://scenes/SantuarioGG.tscn")
var santuario_muerte =preload("res://scenes/SantuarioSM.tscn")

var tipos_obstaculos = [basura_scene, cascote_scene, gomas_scene]
var buffs = [santuario_gauchito, santuario_muerte]
var obstaculos : Array

var carriles : Array
var posSantuarios
var posParada

#Constantes del juego
const START_SPEED = 5
const MAX_SPEED = 25
const DIST_MODIFIER = 10
const SPEED_MODIFIER = 500

#Variables del juego
var traveled_distance : int 
var speed : float
var ult_obstaculo 

#variable para establcer el estado del juego
var game_over = false

#variables y encenas de los pasajeros
@onready var pasajeros_contenedor = $Pasajeros
@onready var spawn_timer = $TimerPasajeros
var pasajero_scene: PackedScene = preload("res://scenes/hombre.tscn")



func _ready():
	#conectar las señales del HUD con las funciones del Main
	var temporizador = $HUD
	temporizador.connect("perder_signal", Callable(self, "perder_nivel"))
	temporizador.connect("reiniciar_signal", Callable(self, "reiniciar_nivel"))
	
	traveled_distance = 0
	carriles = [
		$Carril1,
		$Carril2
	]
	posSantuarios = $PosSantuario
	posParada = $PosParada
	
func _process(_delta):
	#para hacer que el juego se detenga al perder
	if game_over == true:
		return
	
	speed = int(START_SPEED + (traveled_distance /  SPEED_MODIFIER))
	#print(speed)

	$Bondi.position.x += speed
	$Camera2D.position.x += speed

	traveled_distance += int(speed / DIST_MODIFIER)
	
	gen_obstaculos()
	

	#show_distance()

#func show_distance():
#	$HUD.get_node("DistanceLabel").text = "Distancia recorrida: " + str(traveled_distance)


#Generacion randomizada

func gen_obstaculos():
	if obstaculos.is_empty():
		
		#Generar objeto random
		var obs_tipo = tipos_obstaculos[randi() % tipos_obstaculos.size()]
		var obs
		#instanciarlo
		obs = obs_tipo.instantiate()
		ult_obstaculo = obs
		
		#randomizar en que carril aparece
		var spawn_point = carriles[randi() % carriles.size()] 
		print (obs.position.y) # para debug
		obs.position = spawn_point.position
		add_child(obs)
		
		#lo agrega al array de objetos spawneados. 
		obstaculos.append(obs)


#funcion que cambia el game_over a true para que se detenga el juego
func perder_nivel():
	game_over = true

#funcion que reinicia la escena(nivel) al apretar el boton reiniciar (esta en el HUD)	
func reiniciar_nivel():
	get_tree().reload_current_scene()

#timer que genera a los pasajeros
func _on_timer_pasajeros_timeout():
	spawn_pasajeros()

#funcion spawn de los pasajeros
func spawn_pasajeros():
	var pasajeros = pasajero_scene.instantiate()
	pasajeros_contenedor.add_child(pasajeros)
	
	const Y_FIJO = 334 #punto fijo (donde estaria la parada)
	var x_spawn = 1200 #punto para que aparezca fuera de pantalla asi no aparece de la nada
	var posicion_spawn = Vector2($Bondi.global_position.x + x_spawn, Y_FIJO)
	
	pasajeros.global_position = posicion_spawn
	print("pos pasajero: ", posicion_spawn) #para revisar las posiciones
