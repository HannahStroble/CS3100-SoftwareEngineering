extends Area2D

func _ready():
	$AnimatedSprite.play("idle")



func _on_mysteryBox_body_entered(body):
	if "Player" in body.name:
		body.mysteryBox()
		queue_free()
