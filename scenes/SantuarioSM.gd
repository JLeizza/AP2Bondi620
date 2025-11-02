extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overlapping = get_overlapping_areas()
	for area in overlapping:
		if area.name == "StopsArea":  # El StopsArea del bondi
			if Input.is_action_just_pressed("stop"):
				activate(area.get_parent())  # El padre es el Bondi
				queue_free()

func activate(bondi):

		bondi.take_damage(Cte.DAÑO_SM)
		bondi.modify_speed(10, 30)
