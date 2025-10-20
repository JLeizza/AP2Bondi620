extends Node


const START_SPEED = 10
const MAX_SPEED = 25
const DIST_MODIFIER = 10

var traveled_distance : int 
var speed : float



# Called when the node enters the scene tree for the first time.
func _ready():
	traveled_distance = 0



func _process(delta):
	speed = START_SPEED

	$Bondi.position.x += speed
	$Camera2D.position.x += speed

	traveled_distance += int(speed / DIST_MODIFIER)

	show_distance()

func show_distance():
	$HUD.get_node("DistanceLabel").text = "Distancia recorrida: " + str(traveled_distance)
