extends TileMap
var camera_limit_bottom = 0
var camera_limit_right = 0

onready var PLAYER = preload("res://src/Actor/Player.tscn")

func _ready() -> void:

	var world = get_tree().get_root()
	var file = File.new()
	var err = file.open("res://src/Level/level1.txt", file.READ)
	if err != OK:
		printerr("Could not open file, error code", err)
		return
	var x_cord = 0
	var y_cord = 0

	while not file.eof_reached():
		for i in file.get_line():
			
			# set stone version 1
			if i == "a":
				call_deferred("set_cell",x_cord,y_cord,2)
				x_cord += 1

			# set block version 1
			elif i == "b":
				call_deferred("set_cell",x_cord,y_cord,1)
				x_cord += 1

			# set brick version 1
			elif i == "c":
				#call_deferred("set_cell",x_cord,y_cord,2)
				var brick = preload("res://src/Objects/Brick.tscn")
				var new_brick = brick.instance()
				world.call_deferred("add_child", brick)
				# set position
				new_brick.position.x = x_cord*16
				new_brick.position.y = y_cord*16
				x_cord += 1

			# set stone version 2
			elif i == "j":
				call_deferred("set_cell",x_cord,y_cord,5)
				x_cord += 1

			# set block version 2
			elif i == "k":
				call_deferred("set_cell",x_cord,y_cord,4)
				x_cord += 1

			elif i == "l":
				#call_deferred("set_cell",x_cord,y_cord,5)
				var brick2 = preload("res://src/Objects/Brick2.tscn")
				var new_brick2 = brick2.instance()
				world.call_deferred("add_child",new_brick2)
				# set position
				new_brick2.position.x = x_cord*16
				new_brick2.position.y = y_cord*16
				x_cord += 1

			# set player object
			elif i == "P":
				var new_PLAYER = PLAYER.instance()
				world.call_deferred("add_child",new_PLAYER)
				# set position, speed and gravity
				new_PLAYER.position.x = x_cord*16
				new_PLAYER.position.y = y_cord*16
				new_PLAYER.speed.x = 150.0
				new_PLAYER.speed.y = 550.0
				new_PLAYER.gravity = 1250.0
				x_cord += 1

			# set enemy object
			elif i == "0":
				var ENEMY0 = preload("res://src/Actor/Enemy0.tscn")
				var new_ENEMY0 = ENEMY0.instance()
				world.call_deferred("add_child",new_ENEMY0)
				# set position
				new_ENEMY0.position.x = x_cord*16
				new_ENEMY0.position.y = y_cord*16
				x_cord += 1

			elif i == "E":
				var coin = preload("res://src/Objects/Coin.tscn")
				var new_coin = coin.instance()
				world.call_deferred("add_child",new_coin)
				# set position
				new_coin.position.x = x_cord*16
				new_coin.position.y = y_cord*16
				x_cord += 1

			elif i == "h":
				var portal = preload("res://src/Objects/Portal.tscn")
				var new_portal = portal.instance()
				world.call_deferred("add_child", new_portal)
				# set position
				new_portal.position.x = x_cord*16
				new_portal.position.y = y_cord*16
				x_cord += 1

			# set blank background
			elif i == " " or i == "_":
				x_cord += 1


		y_cord += 1
		x_cord = 0
		
		print(world.get_node("new_Player/Camera2D"))
	file.close()