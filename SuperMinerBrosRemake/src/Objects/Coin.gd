extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
export var score: = 100
#used for giving player extra lives when they get 100 coins

func _on_body_entered(body: PhysicsBody2D) -> void:
	PlayerData.score += score
	PlayerData.coins += 1

	if PlayerData.coins / PlayerData.bonus_lives == 100:
		PlayerData.bonus_lives += 1
		PlayerData.lives += 1
	queue_free()
