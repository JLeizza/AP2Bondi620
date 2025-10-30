extends CharacterBody2D

# Variables de Bondi
var main 
var move = 50
var initial_position = 410 
var speed 
var traveled_distance : int 
var puntos = 0

func _ready():
	position.y = initial_position

#funcion que suma pasajeros y trae al HUD para mostrar la cantidad
func sumar_pasajero():
	puntos += 1
	var hud = get_node("/root/Main/HUD")
	hud.get_node("Pasajeros").text = "Pasajeros: " + str(puntos)

func _process(_delta):
	pass

func _physics_process(_delta):

	if not is_inside_tree():
		return

# Input de movimiento.
	if Input.is_action_just_pressed("ui_up") && position.y != initial_position :
		position.y -= move

	if Input.is_action_just_pressed("ui_down") && position.y != initial_position + move:
		position.y += move
