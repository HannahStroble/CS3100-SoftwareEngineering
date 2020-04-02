extends StaticBody2D


func _on_firefloorArea_body_entered(body):
	if "Player" in body.name:
		# Decrease Health
		body.damage(25)
		# Bounce upward
		body._velocity.y -= body.gravity / 2

