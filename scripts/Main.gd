extends Node


const START_SPEED = 10
const MAX_SPEED = 25


var speed : float


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	speed = START_SPEED

	$Bondi.position.x += speed
	$Camera2D.position.x += speed

	pass
