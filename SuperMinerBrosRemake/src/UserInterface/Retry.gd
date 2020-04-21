extends Button

func _on_button_up() -> void:
	PlayerData.score = 0
	PlayerData.coins = 0
	PlayerData.time = 365
	PlayerData.score = 0
	PlayerData.bonus_lives = 1
	PlayerData.size = 1
	get_tree().paused = false
	get_tree().reload_current_scene()
