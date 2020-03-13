extends TileMap

var startPos: = Vector2(0,0)
var startGen: = Vector2(16, 0)
var curPos: = Vector2(0, 0)
var curPosx : = curPos.x

func _ready() -> void:
	var file = File.new()
	var err = file.open("res://mytext.txt", file.READ)
	if err != OK:
		printerr("Could not open file, error code", err)
		return
	var x_cord = 0
	var y_cord = 0

	for i in file.get_line():
		if i == "X":
			set_cell(x_cord,y_cord,0)
			x_cord += 1
		if i == "\n":
			y_cord += 1
	file.close()
