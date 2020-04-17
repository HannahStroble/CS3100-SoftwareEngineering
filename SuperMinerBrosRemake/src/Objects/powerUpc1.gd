extends Area2D

func _ready():
	$AnimatedSprite.play("idle")

func _on_powerUpc1_body_entered(body):
	if "Player" in body.name:
		body.powerUpc1()
		queue_free()
