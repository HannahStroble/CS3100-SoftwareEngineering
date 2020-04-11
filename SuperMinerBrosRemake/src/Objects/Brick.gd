extends StaticBody2D

var numCoins = 0
var breakable = true

func set_coins(coins : int):
	numCoins = coins
	breakable = false


func _on_BrickHitBox_body_entered(body):
	if numCoins > 0:
		# Add a new coin
		var coin = load("res://src/Objects/Coin.tscn").instance()
		get_parent().add_child(coin)
		# set position
		coin.position.x = body.global_position.x
		coin.position.y = body.global_position.y

		numCoins -= 1
		
	if numCoins == 0:
		if breakable:
			# Delete the box on impact, if it doesn't hold anything.
			queue_free()
		else:
			#used to change the block to a dead box upon impact
			get_node("brickSprite").hide() 
	return

