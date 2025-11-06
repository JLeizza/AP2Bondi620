extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overlapping = get_overlapping_areas()
	for area in overlapping:
#		print("Área detectada: ", area.name)  # Debug
		if area.name == "StopsArea":
#			print("StopsArea detectada!")  # Debug
			if Input.is_action_just_pressed("stop"):
#				print("Espacio presionado!")  # Debug
				print("ganaste")
