extends Area2D

func _on_powerUpc2_body_entered(body):
	queue_free()
	if "Player" in body.name:
		PlayerData.power_up = true
		if PlayerData.size == 1:
			PlayerData.size = 3
		elif PlayerData.size == 2:
			PlayerData.size = 3
		else:
			PlayerData.lives += 1
