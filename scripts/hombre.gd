extends CharacterBody2D

@onready var area = $Area2D

func _ready():
	pass

#funcion que detecta la colision con el grupo "Bondi", suma al pasajero y lo elimina
func _on_area_2d_body_entered(body):
	if body.is_in_group("Bondi"):
		body.sumar_pasajero()
		queue_free()
