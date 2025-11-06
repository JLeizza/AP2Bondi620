extends CharacterBody2D

# Variables de Bondi
var main 
var move = 50
var initial_position = 410 
var speed = Cte.START_SPEED
var traveled_distance : int 
var lifes : int = Cte.BONDI_MAX_LIFE

func _ready():
	position.y = initial_position

func _process(_delta):
	pass

func _physics_process(_delta):

	if not is_inside_tree():
		return
		
	velocity.x = speed
	move_and_slide()



# Input de movimiento.
	if Input.is_action_just_pressed("ui_up") && position.y != initial_position :
		position.y -= move

	if Input.is_action_just_pressed("ui_down") && position.y != initial_position + move:
		position.y += move
		
func take_damage(damage):
	lifes -= damage
	if lifes < 0:
		lifes = 0
	get_node("/root/Main/HUD").update_health(lifes, Cte.BONDI_MAX_LIFE)

func modify_speed(buff, duration):
	if duration > 0:
		var original_speed = speed
		speed += buff
		await get_tree().create_timer(duration).timeout
		speed = Cte.START_SPEED
	else:
		speed += buff

func heal(amount):
	lifes += amount
	if lifes > Cte.BONDI_MAX_LIFE:
		lifes = Cte.BONDI_MAX_LIFE
	get_node("/root/Main/HUD").update_health(lifes, Cte.BONDI_MAX_LIFE)

func handle_speed():
	if speed > Cte.MAX_SPEED:
		speed = Cte.MAX_SPEED
	elif speed < 300:
		speed += Cte.TIMER_STRONG_BUFF
	elif speed >= 300 and speed < 700:
		speed += Cte.TIMER_LIGHT_BUFF
