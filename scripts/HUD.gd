extends CanvasLayer

# --- CONSTANTES DE COLOR ---
const DEFAULT_COLOR = Color(1.0, 1.0, 1.0)  # Blanco (o el color original)
const WARNING_COLOR = Color.YELLOW          # Amarillo (< 60s)
const DANGER_COLOR = Color.RED              # Rojo (< 30s)
const CRITICAL_COLOR = Color(0.6, 0.0, 0.0) # Rojo oscuro (< 10s)
#variables temporizador y game over
@onready var tiempo = $TiempoPantalla
@onready var temporizador = $Temporizador
@onready var perder_nivel = $PerderNivel

#Array de la vida
var hearts : Array = []

#Texturas corazon lleno y vacio
var heart_full : Texture2D = preload("res://sprites/HealthHeart.png")
var heart_rip : Texture2D = preload("res://sprites/RipHeart.png")

#señales perder y reiniciar
signal perder_signal
signal reiniciar_signal

func _ready():
	temporizador.start() #Inicializa el temporizador
	# Asegurarse de que el color inicial sea el predeterminado
	tiempo.add_theme_color_override("font_color", DEFAULT_COLOR)
	perder_nivel.visible = false #oculta la pantalla de perder
	emit_signal("reiniciar_signal")
	hearts = $Vidas.get_children()

func _process(delta):
	var tiempo_faltante = temporizador.time_left # Obtiene el tiempo restante
	#muestra el tiempo en pantalla
	if temporizador.time_left > 0:
		tiempo.text = "%02d:%02d" % tiempo_atras()
		update_timer_color(tiempo_faltante)
	else:
		perder()

#funcion para convierte el tiempo y devuelve el valor en minutos y segundos
func tiempo_atras():
	var tiempo_faltante = temporizador.time_left
	var minutos = floor(tiempo_faltante / 60)
	var segundos = int(tiempo_faltante) % 60
	return [minutos, segundos]

func update_timer_color(current_time_left: float):
	var new_color: Color

	# Condición para Rojo Oscuro (Crítico: < 10 segundos)
	if current_time_left < 10.0:
		new_color = CRITICAL_COLOR
	
	# Condición para Rojo Brillante (Peligro: < 30 segundos, pero >= 10)
	elif current_time_left < 30.0:
		new_color = DANGER_COLOR
		
	# Condición para Amarillo (Advertencia: < 60 segundos, pero >= 30)
	elif current_time_left < 60.0:
		new_color = WARNING_COLOR
		
	# Condición por defecto (1 minuto o más)
	else:
		new_color = DEFAULT_COLOR

	# Solo actualiza el color si es diferente para evitar llamadas innecesarias
	# Aunque add_theme_color_override es eficiente, esta es una buena práctica
	if tiempo.get_theme_color("font_color") != new_color:
		tiempo.add_theme_color_override("font_color", new_color)

#funcion que muestra la pantalla de perder
func perder():
	perder_nivel.visible = true
	
func update_pasajeros(total_pasajeros):
	$Pasajeros.text= "Pasajeros: " + str(total_pasajeros)

#señal que al apretar el boton se reinicie el temporizador
func _on_reiniciar_boton_pressed():
	emit_signal("reiniciar_signal")
	print("Enviada la señal")
	
func update_health(amount_life, max_life):
	for i in range(len(hearts)):
		if i < amount_life:
			hearts[i].texture = heart_full
		else:
			hearts[i].texture = heart_rip
