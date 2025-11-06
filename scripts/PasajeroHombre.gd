extends Node2D

@onready var enemigos_container = $Node2D
@onready var spawn_timer = $Timer
@export var enemigo_scene: PackedScene = preload("res://scenes/hombre.tscn")

func spawn_enemigo():
	var enemigo = enemigo_scene.instantiate()
	enemigos_container.add_child(enemigo)
	
	# Posición de aparición (por ejemplo, a la derecha del jugador)
	var Bondi = get_node("res//scenes/Bondi.tscn")
	var distancia_spawn = 500  # distancia en píxeles
#    var posicion_spawn = jugador.global_position + Vector2(distancia_spawn, randf_range(-100, 100))
	var posicion_spawn = Bondi.global_position + Vector2(600, 0)
	
	enemigo.global_position = posicion_spawn
	print("Enemigo generado en: ", posicion_spawn)
