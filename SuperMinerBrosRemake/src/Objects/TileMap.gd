extends TileMap


func _ready() -> void:

	var world = get_tree().get_root()
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
				call_deferred("set_cell",x_cord,y_cord,2)
				x_cord += 1
			elif i == "P":#player place holder
				var PLAYER = preload("res://src/Actor/Player.tscn")
				var new_PLAYER = PLAYER.instance()
				world.call_deferred("add_child",new_PLAYER)
				new_PLAYER.position.x = x_cord*16
				new_PLAYER.position.y = y_cord*16
				new_PLAYER.speed.x = 150.0
				new_PLAYER.speed.y = 550.0
				new_PLAYER.gravity = 1250.0
				x_cord += 1
			elif i == "0":
				var ENEMY0 = preload("res://src/Actor/Enemy0.tscn")
				var new_ENEMY0 = ENEMY0.instance()
				world.call_deferred("add_child",new_ENEMY0)
				new_ENEMY0.position.x = x_cord*16
				new_ENEMY0.position.y = y_cord*16
				x_cord += 1
			elif i == " ":
				x_cord += 1
		y_cord += 1
		x_cord = 0
	file.close()
