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
		bondi.speed = Cte.POMBERITO_LOW_SPEED
		get_tree().create_timer(Cte.POMBERITO_TIMER_LOOP).timeout
		bondi.speed = Cte.POMBERITO_HIGH_SPEED
		get_tree().create_timer(Cte.POMBERITO_TIMER_LOOP).timeout
