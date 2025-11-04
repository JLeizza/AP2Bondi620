extends Node

#
const START_SPEED = 250
const MAX_SPEED = 500
const DIST_MODIFIER = 10
const BONDI_MAX_LIFE = 4
const TIMER_BUFF_SPEED = 50

#OFFSETS
const SPAWN_OFFSET_X = 800  # Píxeles adelante del bondi
const CAMERA_OFFSET_X = -300

##OBSTACULOS Y SANTUARIOS
const SANT_SPAWN_TIME = 12 #Este tiempo es para debug mas facil, en el juego final diria que sea aprox el doble
const OBS_SPAWN_TIME = 10
const DAÑO_OBSTACULO = 1
const DAÑO_SM = 2
const HEALT_SANT_GG = 1
const BUFF_VELOCIDAD_SM = 100

##PARADA
const MIN_PASAJEROS= 1
const MAX_PASAJEROS= 3
const MIN_ENEMIGOS= 0
const MAX_ENEMIGOS= 1
const ENEMY_SPAWN_CHANCE = 0.7
const TIEMPO_RECOGER_PASAJERO = 1


##PACKED SCENESextends Node

const BASURA_SCENE = preload("res://scenes/Basura.tscn")
const CASCOTE_SCENE = preload("res://scenes/Cascote.tscn")
const GOMAS_SCENE = preload("res://scenes/Gomas.tscn")
const SANTUARIO_GAUCHITO = preload("res://scenes/SantuarioGG.tscn")
const SANTUARIO_MUERTE = preload("res://scenes/SantuarioSM.tscn")
const PARADA_SCENE = preload("res://scenes/Parada.tscn")
