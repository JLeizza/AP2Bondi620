extends Control

func _on_volver_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_siguientecontrol_pressed():
	$Objetivo.visible = false
	$controles.visible = true


func _on_siguienteruta_pressed():
	$controles.visible = false
	$danosruta.visible = true


func _on_atrasobjetivo_pressed():
	$Objetivo.visible = true
	$controles.visible = false


func _on_siguienteenemigos_pressed():
	$danosruta.visible = false
	$enemigos.visible = true


func _on_atrascontroles_pressed():
	$controles.visible = true
	$danosruta.visible = false


func _on_atrasdanosruta_pressed():
	$danosruta.visible = true
	$enemigos.visible = false
