extends StaticBody2D

export var numCoins = 0
var breakable = true
onready var world = get_tree().get_root()
onready var timer = get_node("Timer")

func _ready():
	timer.set_wait_time(.5)
func set_coins(coins : int):
	numCoins = coins
	breakable = false

func _on_BrickHitBox_body_entered(body):
	
	if numCoins > 0:
		# Add a new coin
		var coin = preload("res://src/Objects/Coin.tscn").instance()
		world.call_deferred("add_child", coin)
		# set position
		coin.position.x = self.global_position.x
		coin.position.y = self.global_position.y - 16
		numCoins -= 1
		PlayerData.coins += 1
		timer.start()
		yield(timer, "timeout")
		coin.queue_free()
	if numCoins == 0:
		timer.queue_free()
		if breakable:
			# Delete the box on impact, if it doesn't hold anything.
			queue_free()
		else:
			#used to change the block to a dead box upon impact
			get_node("brickSprite").hide()

	return


