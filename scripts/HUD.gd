extends CanvasLayer

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
	perder_nivel.visible = false #oculta la pantalla de perder
	emit_signal("reiniciar_signal")
	hearts = $Vidas.get_children()

func _process(delta):
	#muestra el tiempo en pantalla
	if temporizador.time_left > 0:
		tiempo.text = "%02d:%02d" % tiempo_atras()
	else:
		perder()

#funcion para convierte el tiempo y devuelve el valor en minutos y segundos
func tiempo_atras():
	var tiempo_faltante = temporizador.time_left
	var minutos = floor(tiempo_faltante / 60)
	var segundos = int(tiempo_faltante) % 60
	return [minutos, segundos]

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
