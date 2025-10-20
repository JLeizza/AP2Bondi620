extends KinematicBody2D


var move = 50
var initial_posisition = 410
var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _physics_process(delta):

	$Bondi.position.x += speed	

	if Input.is_action_just_pressed("ui_up") && position.y != initial_posisition :
		position.y -= move
	if Input.is_action_just_pressed("ui_down") && position.y != initial_posisition + move:
		position.y += move

