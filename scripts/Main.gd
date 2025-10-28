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
var timer_obs
var timer_paradas
var timer_santuarios

# Constantes del juego
const START_SPEED = 5
const MAX_SPEED = 25
const DIST_MODIFIER = 10
const SPEED_MODIFIER = 500
const SPAWN_OFFSET_X = 800  # Píxeles adelante del bondi

# Variables del juego
var traveled_distance: int = 0
var speed: float = 0.0

func _ready():
	print("=== INICIALIZANDO MAIN ===")
	
	# Inicializar arrays
	tipos_obstaculos = [basura_scene, cascote_scene, gomas_scene]
	buffs = [santuario_gauchito, santuario_muerte]
	
	# Obtener referencias a nodos
	carriles = [$Carril1, $Carril2]
	print("Carriles encontrados: ", carriles.size())
	for i in carriles.size():
		print("  Carril ", i, " posición Y: ", carriles[i].position.y)
	
	posSantuarios = $PosSantuario
	print("PosSantuario posición Y: ", posSantuarios.position.y)
	
	posParada = $PosParada
	bondi = $Bondi
	print("Bondi posición inicial: ", bondi.position)
	
	camera = $Camera2D
	hud = $HUD
	timer_obs = $Timers/TimerObs
	timer_paradas = $Timers/TimerParadas
	timer_santuarios = $Timers/TimerSantuarios
	
	traveled_distance = 0
	set_timers()
	
	print("=== INICIALIZACIÓN COMPLETA ===")

func _process(_delta):
	speed = int(START_SPEED + (traveled_distance / SPEED_MODIFIER))
	
	bondi.position.x += speed
	camera.position.x += speed
	traveled_distance += int(speed / DIST_MODIFIER)
	
	show_distance()

func show_distance():
	hud.get_node("DistanceLabel").text = "Distancia recorrida: " + str(traveled_distance)

func _on_timer_obs_timeout():
	print(">>> Timer obstáculos activado!")
	gen_obstaculos()

func _on_timer_paradas_timeout():
	pass # Replace with function body.

func _on_timer_santuarios_timeout():
	print(">>> Timer santuarios activado!")
	gen_santuario()

# Timers
func set_timers():
	print("Configurando timers...")
	
	timer_obs.timeout.connect(_on_timer_obs_timeout)
	timer_santuarios.timeout.connect(_on_timer_santuarios_timeout)
	
	timer_obs.wait_time = 5
	timer_obs.start()
	print("  Timer obstáculos: ", timer_obs.wait_time, "s")
	
	timer_santuarios.wait_time = 15
	timer_santuarios.start()
	print("  Timer santuarios: ", timer_santuarios.wait_time, "s")

# Generación randomizada
func gen_santuario():
	print("--- Generando santuario ---")
	
	# Generar objeto random
	var santuario_scene = buffs.pick_random()
	print("  Escena elegida: ", santuario_scene)
	
	# Instanciarlo
	var sant = santuario_scene.instantiate()
	print("  Santuario instanciado: ", sant)
	
	# X = bondi + 800, Y = del marker
	var spawn_x = bondi.position.x + SPAWN_OFFSET_X
	var spawn_y = posSantuarios.position.y
	sant.position = Vector2(spawn_x, spawn_y)
	
	print("  Posición asignada: ", sant.position)
	print("  (Bondi en X: ", bondi.position.x, ")")
	
	add_child(sant)
	print("  Hijo agregado. Total hijos: ", get_child_count())
	
	lastSantuario = sant

func gen_obstaculos():
	print("--- Generando obstáculo ---")
	
	var obs_tipo = tipos_obstaculos.pick_random()
	
	# Evitar repetir el mismo obstáculo consecutivo
	while obs_tipo == ult_obstaculo and tipos_obstaculos.size() > 1:
		obs_tipo = tipos_obstaculos.pick_random()
	
	print("  Tipo elegido: ", obs_tipo)
	
	# Instanciarlo
	var obs = obs_tipo.instantiate()
	ult_obstaculo = obs_tipo
	print("  Obstáculo instanciado: ", obs)
	
	# Randomizar carril
	var carril_elegido = carriles.pick_random()
	
	# X = bondi + 800, Y = del carril elegido
	var spawn_x = bondi.position.x + SPAWN_OFFSET_X
	var spawn_y = carril_elegido.position.y
	obs.position = Vector2(spawn_x, spawn_y)
	
	print("  Carril Y: ", spawn_y, " - Posición final: ", obs.position)
	print("  (Bondi en X: ", bondi.position.x, ")")
	
	add_child(obs)
	print("  Hijo agregado. Total hijos: ", get_child_count())
