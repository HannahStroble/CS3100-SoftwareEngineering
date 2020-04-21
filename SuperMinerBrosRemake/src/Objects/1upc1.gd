extends Area2D
onready var AudioPlayer = get_node("AudioStreamPlayer")
onready var sprite = get_node("AnimatedSprite")
onready var shape = get_node("CollisionShape2D")

func _on_1upc1_body_entered(body):
	if "Player" in body.name and PlayerData.size == 1 and self.get_collision_mask_bit(0) == true:
		PlayerData.size += 1
		body.grow()
		sprite.visible = false
		self.set_collision_mask_bit(0,false)
		AudioPlayer.play()
	elif "Player" in body.name and PlayerData.size == 2 and self.get_collision_mask_bit(0) == true:
		PlayerData.lives += 1
		AudioPlayer.play()