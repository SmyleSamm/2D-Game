extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.set_collision_mask_value(1, false)
		
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.set_collision_mask_value(1, true)
		
