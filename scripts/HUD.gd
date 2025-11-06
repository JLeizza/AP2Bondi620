extends CanvasLayer

# --- CONSTANTES DE COLOR ---
const DEFAULT_COLOR = Color(1.0, 1.0, 1.0)  # Blanco (o el color original)
const WARNING_COLOR = Color.YELLOW          # Amarillo (< 60s)
const DANGER_COLOR = Color.RED              # Rojo (< 30s)
const CRITICAL_COLOR = Color(0.6, 0.0, 0.0) # Rojo oscuro (< 10s)
#variables temporizador progress bars y game over
@onready var tiempo = $TiempoPantalla
@onready var temporizador = $Temporizador
@onready var perder_nivel = $PerderNivel
@onready var progressbar_verde = $TextureProgressBar
@onready var progressbar_verde_oscuro =$TextureProgressBar/TextureProgressBar1
@onready var progressbar_amarillo =$TextureProgressBar/TextureProgressBar2
@onready var progressbar_rojo =$TextureProgressBar/TextureProgressBar3
@onready var velocidad_label = $TextureProgressBar/Velocimetro
# NUEVA: Array para manejar las barras secuencialmente
@onready var progressbar_segmentos = [
	progressbar_verde,
	progressbar_verde_oscuro,
	progressbar_amarillo,
	progressbar_rojo
]
#Array de la vida
var hearts = []

##Texturas corazon lleno y vacio
#var heart_full : Texture2D = preload("res://sprites/HealthHeart.png")
#var heart_rip : Texture2D = preload("res://sprites/RipHeart.png")

#señales perder y reiniciar
signal perder_signal
signal reiniciar_signal

func _ready():
	temporizador.start() #Inicializa el temporizador
	# Asegurarse de que el color inicial sea el predeterminado
	tiempo.add_theme_color_override("font_color", DEFAULT_COLOR)
	perder_nivel.visible = false #oculta la pantalla de perder
	emit_signal("reiniciar_signal")
	for child in $Vidas.get_children():
		if child is AnimatedSprite2D:
			hearts.append(child)
			child.play("Full")

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

# --- NUEVA FUNCIÓN PARA ACTUALIZAR EL VELOCÍMETRO ---
# max_bus_speed se obtiene de tus constantes (Cte.MAX_SPEED = 600)
func update_speedometer(current_bus_speed: float, max_bus_limit: float):
	
	# 1. Mapear la velocidad real (0 a max_bus_limit) a un valor de progreso (0 a 100)
	var total_progress_value = (current_bus_speed / max_bus_limit) * 100
	
	# Limitar el valor entre 0 y 100
	total_progress_value = clamp(total_progress_value, 0.0, 100)
	
	# 2. Actualizar el Label de velocidad
	velocidad_label.text = "KM/H: " + str(int(current_bus_speed/10)) 

	# 3. Lógica de Relleno Secuencial para las 4 barras
	var remaining_progress = total_progress_value
	
	for i in range(progressbar_segmentos.size()):
		var current_bar = progressbar_segmentos[i]
		
		# Configuramos el MaxValue de cada barra a 25.
		current_bar.max_value = 25
		
		var value_to_fill = 0.0
		
		if remaining_progress >= 25:
			# Si queda suficiente progreso para llenar toda la barra (ej. Velocidad > 50 -> llena barra 3)
			value_to_fill = 25
		elif remaining_progress > 0.0:
			# Si queda progreso parcial para llenar (ej. Velocidad 55 -> llena barra 3 a 5 unidades)
			value_to_fill = remaining_progress
		# Si no queda progreso (remaining_progress <= 0), value_to_fill es 0.0
		
		current_bar.value = value_to_fill
		
		# Restar el progreso asignado para la siguiente iteración
		remaining_progress -= value_to_fill
#funcion que muestra la pantalla de perder
func perder():
	perder_nivel.visible = true
	
func update_pasajeros(total_pasajeros):
	$Pasajeros.text= ": " + str(total_pasajeros)

#señal que al apretar el boton se reinicie el temporizador
func _on_reiniciar_boton_pressed():
	emit_signal("reiniciar_signal")
	print("Enviada la señal")
	
func update_health(amount_life, max_life):
	for i in range(len(hearts)):
		if i < amount_life:
			hearts[i].play("Full")
		else:
			hearts[i].play("Rip")

