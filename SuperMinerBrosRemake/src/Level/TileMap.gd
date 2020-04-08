extends TileMap

# run when level starts
func _ready() -> void:
	# call correct world object
	var world = get_tree().get_root()
	
	# create new file and open file
	var file = File.new()
	var err = file.open("res://src/Level/level1.txt", file.READ)
	
	# if file is not ok, then print error and stop
	if err != OK:
		printerr("Could not open file, error code", err)
		return
		
	# position variables
	var x_cord = 0.0
	var y_cord = 0.0
	
	# while end of file is not reached
	while not file.eof_reached():
		for i in file.get_line():
			
			# set static background tiles
			# set stone version 1
			if i == "a":
				call_deferred("set_cell",x_cord,y_cord,2)
				x_cord += 1
			
			# set block version 1
			if i == "b":
				call_deferred("set_cell",x_cord,y_cord,1)
				x_cord += 1
			
			# set brick version 1 or single coin brick v1
			if i == "c" or i == "A" or i == "d":
				#call_deferred("set_cell",x_cord,y_cord,2)
				var brick = load("res://src/Objects/Brick.tscn").instance()
				if i == "A":
					brick.set_coins(1)
				elif i == "d":
					brick.set_coins(2)
				add_child(brick)
				
				# set position
				brick.position.x = x_cord*16
				brick.position.y = y_cord*16
				x_cord += 1
			
			
			# set stone version 2
			if i == "j":
				call_deferred("set_cell",x_cord,y_cord,5)
				x_cord += 1
			
			# set block version 2
			if i == "k":
				call_deferred("set_cell",x_cord,y_cord,4)
				x_cord += 1
			
			# set brick version 2
			if i == "l":
				#call_deferred("set_cell",x_cord,y_cord,5)
				var brick2 = load("res://src/Objects/Brick2.tscn").instance()
				add_child(brick2)
				
				# set position
				brick2.position.x = x_cord*16
				brick2.position.y = y_cord*16
				x_cord += 1
			
			# set blank background
			elif i == " " or i == "_":
				x_cord += 1
				
			# set player object
			elif i == "P":
				var load_PLAYER = preload("res://src/Actor/Player.tscn")
				var PLAYER = load_PLAYER.instance()
				world.call_deferred("add_child", PLAYER)
				
				# set position, speed and gravity
				PLAYER.position.x = x_cord*16
				PLAYER.position.y = y_cord*16
				PLAYER.speed.x = 150.0
				PLAYER.speed.y = 550.0
				PLAYER.gravity = 1250.0
				x_cord += 1
				
			# set enemy object
			elif i == "0":
				var ENEMY0 = load("res://src/Actor/Enemy.tscn").instance()
				add_child(ENEMY0)
				
				# set position
				ENEMY0.position.x = x_cord*16
				ENEMY0.position.y = y_cord*16
				x_cord += 1
				
			# set star object
			elif i == "E":
				var coin = load("res://src/Objects/Coin.tscn").instance()
				add_child(coin)
				
				# set position
				coin.position.x = x_cord*16
				coin.position.y = y_cord*16
				x_cord += 1
				
			# set portal object
			elif i == "h":
				var portal = load("res://src/Objects/Portal.tscn").instance()
				add_child(portal)
				
				# set position
				portal.position.x = x_cord*16
				portal.position.y = y_cord*16
				x_cord += 1
				
		# advance to next line, set positions
		y_cord += 1
		x_cord = 0
		
	# close file
	file.close()
