extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("idle")
	

func _on_1upc1_body_entered(body):
	if "Player" in body.name:
		body.oneUpc1()
		queue_free()
