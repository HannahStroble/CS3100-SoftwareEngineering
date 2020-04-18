extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("idle")
	
func _on_1upc2_body_entered(body):
	if "Player" in body.name:
		body.oneUpc2()
		queue_free()
