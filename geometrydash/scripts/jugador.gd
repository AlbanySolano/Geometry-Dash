extends CharacterBody2D


var SPEED = 32500
const JUMP_VELOCITY = -600

var isOrb = false
var fuerzaOrb = 0

var gravity = 800

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
	if Input.is_action_pressed("salto") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# controla que el jugador se mueva solo a la derecha
	velocity.x = SPEED * delta
	
	if isOrb and (Input.is_action_just_pressed("salto") or Input.is_action_just_released("salto")):
		velocity.y = -fuerzaOrb
	
	move_and_slide()
	
func death():
	SPEED = 0
	$Sprite2D.visible = false
	$Timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()

func _on_externo_area_entered(area):
	if area.is_in_gropu("orbe"):
		isOrb = true
		fuerzaOrb = area.fuerza

func _on_externo_area_exited(area):
	if area.is_in_gropu("orbe"):
		isOrb = false
		fuerzaOrb = 0 
