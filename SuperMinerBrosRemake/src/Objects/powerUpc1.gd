extends Area2D

func _on_powerUpc1_body_entered(body):
	if "Player" in body.name:
		queue_free()
