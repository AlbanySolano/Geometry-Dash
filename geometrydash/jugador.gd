extends CharacterBody2D


var SPEED = 32500
const JUMP_VELOCITY = -600

var gravity = 700


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
	
	move_and_slide()
	
func death():
	SPEED = 0
	$Sprite2D.visible = false
	$Timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
