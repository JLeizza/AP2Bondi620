extends Control

func _ready():
	visible = false

func _process(delta):
	menu_visible()

func continuar():
	get_tree().paused = false
	visible = false
	
func pausa():
	get_tree().paused = true
	visible = true
	AudioManager.restart_music()

func _on_continuar_pressed():
	continuar()

func _on_reiniciar_pressed():
	get_tree().reload_current_scene()
	continuar()

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func menu_visible():
	if Input.is_action_just_pressed("ui_cancel") and !get_tree().paused:
		pausa()
	elif Input.is_action_just_pressed("ui_cancel") and get_tree().paused:
		continuar()
