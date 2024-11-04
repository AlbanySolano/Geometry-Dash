extends Sprite2D




func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("jugador"):
		print("res://escenas/level_" + str(int(get_tree().current_scene.name) +1) + ".tscn")
		get_tree().change_scene("res://escenas/level_" + str(int(get_tree().current_scene.name) +1) + ".tscn")
