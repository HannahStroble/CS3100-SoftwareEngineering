extends Node2D
 
var camera_limit_bottom = 0
var camera_limit_right = 0
onready var Tiles: TileMap = get_node("Tiles")
onready var PLAYER: KinematicBody2D = get_node("Player")
onready var camera: Camera2D = get_node("Player/Camera2D")

func _ready() -> void:

	camera.make_current()
	var file = File.new()
	var err = file.open("res://src/Level/level1.txt", file.READ)
	if err != OK:
		printerr("Could not open file, error code", err)
		return
	var x_cord = 0
	var y_cord = 0

	#trying to parse file looking for end level delimiter
	var whole_file = file.get_as_text()
	print(whole_file.split("|"))
	while not file.eof_reached():
		for i in file.get_line():

			# set stone version 1
			if i == "a":
				Tiles.set_cell(x_cord, y_cord, 2)
				x_cord += 1

			# set block version 1
			elif i == "b":
				Tiles.set_cell(x_cord , y_cord, 1)
				x_cord += 1

			# set brick version 1
			elif i == "c":
				#call_deferred("set_cell",x_cord,y_cord,2)
				var brick = preload("res://src/Objects/Brick.tscn")
				var new_brick = brick.instance()
				add_child(new_brick)
				# set position
				new_brick.position.x = x_cord * 16
				new_brick.position.y = y_cord * 16
				x_cord += 1

			# set stone version 2
			elif i == "j":
				Tiles.set_cell(x_cord, y_cord, 5)
				x_cord += 1

			# set block version 2
			elif i == "k":
				Tiles.set_cell(x_cord, y_cord, 4)
				x_cord += 1

			elif i == "l":
				#call_deferred("set_cell",x_cord,y_cord,5)
				var brick2 = preload("res://src/Objects/Brick2.tscn")
				var new_brick2 = brick2.instance()
				add_child(new_brick2)
				# set position
				new_brick2.position.x = x_cord * 16
				new_brick2.position.y = y_cord * 16
				x_cord += 1

			# set player object
			elif i == "P":
				PLAYER.position.x = x_cord * 16
				PLAYER.position.y = y_cord * 16
				PLAYER.speed.x = 150.0
				PLAYER.speed.y = 550.0
				PLAYER.gravity = 1250.0
				x_cord += 1

			# set enemy object
			elif i == "0":
				var ENEMY0 = preload("res://src/Actor/Enemy0.tscn")
				var new_ENEMY0 = ENEMY0.instance()
				add_child(new_ENEMY0)
				# set position
				new_ENEMY0.position.x = x_cord * 16
				new_ENEMY0.position.y = y_cord * 16
				x_cord += 1

			elif i == "E":
				var coin = preload("res://src/Objects/Coin.tscn")
				var new_coin = coin.instance()
				new_coin.position.x = x_cord * 16
				new_coin.position.y = y_cord * 16
				add_child(new_coin)
				# set position

				x_cord += 1

			elif i == "h":
				var portal = preload("res://src/Objects/Portal.tscn")
				var new_portal = portal.instance()
				self.call_deferred("add_child", new_portal)
				# set position
				new_portal.position.x = x_cord * 16
				new_portal.position.y = y_cord * 16
				x_cord += 1

			# set blank background
			elif i == " " or i == "_":
				x_cord += 1

			if x_cord > camera_limit_right:
				camera_limit_right = x_cord

		y_cord += 1
		x_cord = 0
	print(camera)
	print(camera.limit_bottom)
	print(y_cord)
	camera.limit_right = camera_limit_right * 16
	camera.limit_bottom = -1 * y_cord
	print(camera.limit_bottom)
	print(camera.position)
	print(PLAYER.position)
	camera.position = PLAYER.position
	file.close()
