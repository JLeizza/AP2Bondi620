extends Node

# Carga de obstáculos
var basura_scene = preload("res://scenes/Basura.tscn")
var cascote_scene = preload("res://scenes/Cascote.tscn")
var gomas_scene = preload("res://scenes/Gomas.tscn")
var santuario_gauchito = preload("res://scenes/SantuarioGG.tscn")
var santuario_muerte = preload("res://scenes/SantuarioSM.tscn")

var tipos_obstaculos = []
var buffs = []

var obstaculos: Array = []
var lastSantuario = null
var carriles: Array = []
var posSantuarios = null
var posParada = null
var ult_obstaculo = null

# Referencias a nodos (se inicializan en _ready)
var bondi
var camera
var hud

#Timers
var timer_obs
var timer_paradas
var timer_santuarios
var timer_speed
var timer_game_over

#Colliders
var bondi_obs_collider 
var bondi_stop_collider


# Variables del juego
var traveled_distance: int = 0
var speed: float = 0.0

func _ready():
	print("=== INICIALIZANDO MAIN ===")
	
	init_variables()

	set_timers()
	
	print("=== INICIALIZACIÓN COMPLETA ===")

func _process(_delta):
	camera.position.x = bondi.position.x - Cte.CAMERA_OFFSET_X
	traveled_distance += int(speed / Cte.DIST_MODIFIER)
	bondi.z_index = int(bondi.position.y)
	check_game_over()

# Generación randomizada
func gen_santuario():
	print("--- Generando santuario ---")
	
	# Generar objeto random
	var santuario_scene = buffs.pick_random()
	
	# Instanciarlo
	var sant = santuario_scene.instantiate()
	
	# X = bondi + 800, Y = del marker
	var spawn_x = bondi.position.x + Cte.SPAWN_OFFSET_X
	var spawn_y = posSantuarios.position.y
	sant.position = Vector2(spawn_x, spawn_y)
	sant.z_index = bondi.z_index + 1
	
	print("  Posición asignada: ", sant.position)
	add_child(sant)
	lastSantuario = sant

func gen_obstaculos():
	print("--- Generando obstáculo ---")
	
	var obs_tipo = tipos_obstaculos.pick_random()
	
	# Evitar repetir el mismo obstáculo consecutivo
	while obs_tipo == ult_obstaculo and tipos_obstaculos.size() > 1:
		obs_tipo = tipos_obstaculos.pick_random()
	
#	print("  Tipo elegido: ", obs_tipo)
	
	# Instanciarlo
	var obs = obs_tipo.instantiate()
	ult_obstaculo = obs_tipo
#	print("  Obstáculo instanciado: ", obs)
	
	# Randomizar carril
	var carril_elegido = carriles.pick_random()
	
	# X = bondi + 800, Y = del carril elegido
	var spawn_x = bondi.position.x + Cte.SPAWN_OFFSET_X
	var spawn_y = carril_elegido.position.y
	obs.position = Vector2(spawn_x, spawn_y) 
	
	if carril_elegido == carriles[0]:  # Carril 1 (el de arriba)
		obs.z_index = bondi.z_index - 1  # Siempre detrás del bondi
	else:  # Carril 2 (el de abajo)
		obs.z_index = bondi.z_index + 1 #Siempre adelante
	
	obs.area_entered.connect(hit_obstacule.bind(obs))
	
	add_child(obs)
#	print("  === DEBUG OBSTÁCULO ===")
#	print("  Carril Y elegido: ", spawn_y)
#	print("  Obstáculo Y final: ", obs.position.y)
#	print("  Obstáculo z_index: ", obs.z_index)
#	print("  Bondi z_index: ", bondi.z_index)
	
func remove_obs(obs):
	obs.queue_free()
	obstaculos.erase(obs)
	
func hit_obstacule(body, obs):
	if body == bondi_obs_collider:
		bondi.take_damage(Cte.DAÑO_OBSTACULO)
		remove_obs(obs)
	else: 
		print("Colisione con un objeto que no es ObstaculesArea")
		print("Body: ", body)
		print("Padre de body: ", body.get_parent())

func hit_sant(body, sant):
	if body == bondi_stop_collider:
		if Input.is_action_pressed("stop"):
			sant.activate(bondi)
			print("Colisione con un santuario")
#	else: 
#		print("Colisione con un objeto que no es StopsArea")
#		print("Body: ", body)
#		print("Padre de body: ", body.get_parent())
		
func _on_timer_obs_timeout():
	#print(">>> Timer obstáculos activado!")
	gen_obstaculos()

func _on_timer_paradas_timeout():
	pass # Replace with function body.

func _on_timer_santuarios_timeout():
	#print(">>> Timer santuarios activado!")
	gen_santuario()
	
func init_variables():
	
	# Inicializar arrays
	tipos_obstaculos = [basura_scene, cascote_scene, gomas_scene]
	buffs = [santuario_gauchito, santuario_muerte]
	
	carriles = [$Carril1, $Carril2]
	
	posSantuarios = $PosSantuario
	print("PosSantuario posición Y: ", posSantuarios.position.y)
	
	#Init del Bondi
	bondi = $Bondi
	bondi.z_index = int(bondi.position.y)
	bondi_obs_collider = bondi.get_node("ObstaculesArea")
	bondi_stop_collider = bondi.get_node("StopsArea")
	
	#Init del resto de nodos
	posParada = $PosParada
	camera = $Camera2D
	hud = $HUD
	
	timer_game_over = $HUD/Temporizador
	timer_speed = $Timers/TimerAumentoSpeed
	timer_obs = $Timers/TimerObs
	timer_paradas = $Timers/TimerParadas
	timer_santuarios = $Timers/TimerSantuarios
	traveled_distance = 0

# Timers
func set_timers():
	
	timer_game_over.timeout.connect(game_over)
	timer_obs.timeout.connect(_on_timer_obs_timeout)
	timer_santuarios.timeout.connect(_on_timer_santuarios_timeout)
	timer_speed.timeout.connect(_on_timer_aumento_speed_timeout)
	
	timer_obs.wait_time = Cte.OBS_SPAWN_TIME
	timer_obs.start()
	print("  Timer obstáculos: ", timer_obs.wait_time, "s")
	
	timer_santuarios.wait_time = Cte.SANT_SPAWN_TIME
	timer_santuarios.start()
	print("  Timer santuarios: ", timer_santuarios.wait_time, "s")

func check_game_over():
	if bondi.lifes <= 0:
		game_over()

func game_over():
	get_tree().paused = true
	$HUD/PerderNivel.show()
	

func _on_timer_aumento_speed_timeout():
	bondi.speed += 5
	print(">>> Velocidad aumentada! Nueva velocidad: ", bondi.speed)
