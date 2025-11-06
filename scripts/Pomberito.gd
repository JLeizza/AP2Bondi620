extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate():
	AudioManager.get_node("Pomberito").play()
	
	var main = get_parent().get_parent()
	var bondi = main.bondi
	
	var veces = randi_range(1, 3)
	for i in veces:
		bondi.modify_speed(Cte.POMBERITO_LOW_SPEED, Cte.POMBERITO_TIMER_LOOP)
		bondi.modify_speed(Cte.POMBERITO_HIGH_SPEED, Cte.POMBERITO_TIMER_LOOP)
