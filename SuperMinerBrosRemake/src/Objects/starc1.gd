extends Area2D

func _ready():
	$AnimatedSprite.play("idle")
	

func _on_starc1_body_entered(body):
	if "Player" in body.name:
		body.starc1()
		queue_free()
