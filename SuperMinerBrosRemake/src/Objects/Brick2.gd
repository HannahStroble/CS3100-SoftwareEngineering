extends StaticBody2D


func _on_BrickHitBox_body_entered(body):
	#get_node("brickSprite").hide() #used to change the block to a dead box upon impact
	queue_free() #used to delete the block upon impact
	return

