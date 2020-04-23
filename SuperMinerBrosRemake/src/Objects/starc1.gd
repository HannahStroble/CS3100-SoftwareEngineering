extends Area2D

onready var Audio = get_node("AudioStreamPlayer2D")
onready var sprite = get_node("AnimatedSprite")
onready var shape = get_node("CollisionShape2D")	

func _on_starc1_body_entered(body):
	if "Player" in body.name and self.get_collision_mask_bit(0) == true:
		sprite.visible = false
		self.set_collision_mask_bit(0,false)
		body.iframes()
		Audio.play()
