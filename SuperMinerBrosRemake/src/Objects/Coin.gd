extends Area2D


export var score: = 100
#used for giving player extra lives when they get 100 coins
onready var Coin_Sound_fx = load("res://Assets/Sounds/CoinSound_2.wav")
onready var Sound_FX = get_node("AudioPlayer")
onready var sprite = get_node("coin")

var sound_done = false
func _on_body_entered(body: PhysicsBody2D) -> void:
	if sound_done == true:
		queue_free()
		return
	PlayerData.score += score
	PlayerData.coins += 1
	sound_done = Sound_FX._play_sound(Coin_Sound_fx)
	sprite.visible = false
	if PlayerData.coins / PlayerData.bonus_lives == 100:
		PlayerData.bonus_lives += 1
		PlayerData.lives += 1


