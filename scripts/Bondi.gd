extends KinematicBody2D

var move = 50
var initial_position = 410 
var speed = 10

func _ready():
	# Asegúrate de que la posición inicial esté establecida
	position.y = initial_position

func _physics_process(delta):

	if not is_inside_tree():
		return


	if Input.is_action_just_pressed("ui_up") && position.y != initial_position :
		position.y -= move

	if Input.is_action_just_pressed("ui_down") && position.y != initial_position + move:
		position.y += move
