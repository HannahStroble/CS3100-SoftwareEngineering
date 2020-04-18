extends Area2D

func _ready():
	$AnimatedSprite.play("idle")

func _on_powerUpc2_body_entered(body):
	if "Player" in body.name:
		body.powerUpc2()
		queue_free()
