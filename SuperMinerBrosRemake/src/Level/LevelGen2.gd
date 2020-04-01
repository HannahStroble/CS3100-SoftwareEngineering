extends TileMap

func _ready() -> void:
	var txt = load_txt_file("res://mytext.txt")
	
	
func load_txt_file(path):
	var file = File.new()
	var err = file.open(path, file.READ)
	if err != OK:
		printerr("Could not open file, error code", err)
		return ""
	var text = file.get_as_text()
	file.close()
	print(text)
	return text
