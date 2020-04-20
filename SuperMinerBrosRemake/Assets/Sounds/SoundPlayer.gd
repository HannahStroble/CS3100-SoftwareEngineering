extends Node

func play_sound(Sound_to_be_played):
	print("GOT HERE")
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	print(player)
	player.set_stream( Sound_to_be_played)
	#player.volume_db = 1
	#player.pitch_scale = 1
	player.play()
	#Sound_to_be_played.play()

