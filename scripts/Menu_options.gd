extends Control

@export var audio_bus_name: String

var menu_visible = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_volver_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
