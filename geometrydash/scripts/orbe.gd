extends Area2D

@export var tipo = 0
@onready var sprite = $Sprite2D
var fuerza

func _ready():
	"""
	0 - rosa
	1 - amarilla
	2 - naranja
	3 - roja
	4 - verde
	5 - negra
	"""
	match tipo:
		0:
			fuerza = 600
			sprite.texture = load("res://imagenes/Magenta orbe.png")
		1: 
			fuerza = 900
			sprite.texture = load("res://imagenes/Yellow_Orb.webp")
		2: 
			fuerza = 2000
			sprite.texture = load("res://imagenes/orange-orb.webp")
		3:
			fuerza = 1500
			sprite.texture = load("res://imagenes/Red orbe.png")
		4:
			fuerza = 1800
			sprite.texture = load("res://imagenes/Green orb.png")
		5:
			fuerza = -2000
			sprite.texture = load("res://imagenes/Black orbe.png")
		_:
			fuerza = 0
			sprite.texture = load("res://imagenes/triangle.png")
