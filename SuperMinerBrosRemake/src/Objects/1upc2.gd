extends Area2D

onready var AudioPlayer = get_node("AudioStreamPlayer")
onready var sprite = get_node("AnimatedSprite")
onready var shape = get_node("CollisionShape2D")

func _on_1upc2_body_entered(body):
	if "Player" in body.name and self.get_collision_mask_bit(0) == true:
		PlayerData.lives += 1
		sprite.visible = false
		self.set_collision_mask_bit(0,false)
		AudioPlayer.play()
