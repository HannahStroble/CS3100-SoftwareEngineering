extends Area2D

func _on_powerUpc2_body_entered(body):
	if "Player" in body.name:
		PlayerData.power_up = true
		if PlayerData.size == 1:
			body.bird()
			PlayerData.size = 3
		elif PlayerData.size == 2:
			body.bird()
			PlayerData.size = 3
		else:
			PlayerData.lives += 1
		queue_free()
