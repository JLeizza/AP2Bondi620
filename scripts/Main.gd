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


func _ready():
	traveled_distance = 0
	carriles = [
		$Carril1,
		$Carril2
	]
	posSantuarios = $PosSantuario
	posParada = $PosParada
	
func _process(_delta):
	
	speed = int(START_SPEED + (traveled_distance /  SPEED_MODIFIER))
	#print(speed)

	$Bondi.position.x += speed
	$Camera2D.position.x += speed

	traveled_distance += int(speed / DIST_MODIFIER)
	
	gen_obstaculos()

	show_distance()

func show_distance():
	$HUD.get_node("DistanceLabel").text = "Distancia recorrida: " + str(traveled_distance)


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


