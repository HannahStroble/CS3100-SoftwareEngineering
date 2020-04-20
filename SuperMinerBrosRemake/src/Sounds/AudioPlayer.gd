extends Node

func _play_sound(Sound_path) -> bool:
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = Sound_path
	player.set_pitch_scale(1.0)
	player.play()
	return true