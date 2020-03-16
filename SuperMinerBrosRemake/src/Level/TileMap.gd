extends TileMap


func _ready() -> void:
	var file = File.new()

	var err = file.open("res://mytext.txt", file.READ)
	if err != OK:
		printerr("Could not open file, error code", err)
		return
	var x_cord = 0
	var y_cord = 0
	while not file.eof_reached():
		for i in file.get_line():
			if i == "X":
				set_cell(x_cord,y_cord,0)
				x_cord += 1
			if i == "P":#player place holder
				var PLAYER = preload("res://src/Actor/Player.tscn").instance()
				add_child(PLAYER)
				PLAYER.position.x = x_cord*16
				PLAYER.position.y = y_cord*16
				PLAYER.speed.x = 150.0
				PLAYER.speed.y = 550.0
				PLAYER.gravity = 1250.0
				x_cord += 1
			elif i == "0":
				var ENEMY0 = load("res://src/Actor/Enemy.tscn").instance()
				add_child(ENEMY0)
				ENEMY0.position.x = x_cord*16
				ENEMY0.position.y = y_cord*16
				x_cord += 1
			if i == " ":
				x_cord += 1
		y_cord += 1
		x_cord = 0
	file.close()
