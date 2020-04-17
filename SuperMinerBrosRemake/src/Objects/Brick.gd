extends StaticBody2D

export var itemsRemaining = 0
export var spawnItem = ""
var breakable = true
var variant
onready var world = get_tree().get_root()
onready var timer = get_node("Timer")

func _ready():
	timer.set_wait_time(.5)

func configure(color : int, item : String, amount : int) -> void:
	itemsRemaining = amount
	spawnItem = item;
	variant = color
	
	if spawnItem == "":
		breakable = true
	else:
		breakable = false
	
	if color == 1:
		get_node("brickC1").show()
	elif color == 2:
		get_node("brickC2").show()
		

func _on_BrickHitBox_body_entered(body):
	if body.name != "Player":
		return
	# Just regular brick
	if spawnItem == "":
		queue_free()
	
	if itemsRemaining > 0:
		# Add a new item
		if spawnItem == "coin":
			var item = preload("res://src/Objects/Coin.tscn").instance()
			world.call_deferred("add_child", item)
			# set position
			item.position.x = self.global_position.x
			item.position.y = self.global_position.y - 16
			itemsRemaining -= 1
			# Show deadbox
			if itemsRemaining == 0:
				if variant == 1:
					get_node("brickC1").hide()
					get_node("deadBoxC1").show()
				elif variant == 2:
					get_node("brickC2").hide()
					get_node("deadBoxC2").show()
	
			PlayerData.coins += 1
			timer.start()
			yield(timer, "timeout")
			item.queue_free()
			# Clear timer if this is the last coin
			if itemsRemaining == 0:
				timer.queue_free()

	return


