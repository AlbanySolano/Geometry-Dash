extends CharacterBody2D

var SPEED = 30000.0
var JUMP_VELOCITY = -450.0
var rotacion = 500

var isOrbe = false
var fuerzaorbe = 0
var canInvert = false
var isUfo = false

var gravity = 5000



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		$Sprite2D.rotation_degrees += 380 * delta
	else:
		var modulo = int($Sprite2D.rotation_degrees) % 90;
		if modulo > 45:
			$Sprite2D.rotation_degrees += (90 - modulo)
		else:
			$Sprite2D.rotation_degrees -= modulo

	# Handle jump con el control configurado.
	if Input.is_action_pressed("salto"):
		if isUfo == true or is_on_floor():
			velocity.y = JUMP_VELOCITY

	# controla que el jugador se mueva solo a la derecha
	velocity.x = SPEED * delta
	
	if isOrbe and Input.is_action_just_pressed("salto"):
		velocity.y = -fuerzaorbe
		if canInvert == true :
			gravity = -gravity
			JUMP_VELOCITY = -JUMP_VELOCITY
			rotacion = -rotacion
			isOrbe = false
	move_and_slide()
	
	
func death():
	SPEED = 0
	$Sprite2D.visible = false
	$AudioStreamPlayer2D.play()
	$Timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()

func _on_externo_area_entered(area: Area2D) -> void:
	if area.is_in_group("orbe"):
		isOrbe = true
		fuerzaorbe = area.fuerza
		canInvert = area.invertir
		
	
	if area.is_in_group("trampolines") :
		velocity.y = -area.fuerza
		if area.invertir == true :
			gravity = -gravity
			JUMP_VELOCITY = -JUMP_VELOCITY
			rotacion = -rotacion
	if area.is_in_group("portal") :
		match area.tipo :
			0 :
				$Sprite2D.texture = load("res://imagenes/Ball001.png")
				isUfo = false
			1:
				$Sprite2D.texture = load("res://imagenes/Cube001.png")
				isUfo= false
			2:
				$Sprite2D.texture = load("res://imagenes/Ship001.png")
				isUfo = false
			3:
				$Sprite2D.texture = load("res://imagenes/UFO001.png")
				isUfo = true
				JUMP_VELOCITY = -800
			4:
				$Sprite2D.texture = load("res://imagenes/Wave001.png")
				isUfo = false
				JUMP_VELOCITY = -1200

func _on_externo_area_exited(area: Area2D) -> void:
	if area.is_in_group("orbe"):
			isOrbe = false
			fuerzaorbe = 0
			canInvert = false
