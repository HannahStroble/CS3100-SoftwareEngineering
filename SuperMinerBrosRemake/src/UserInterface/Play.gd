tool
extends Button
onready var scene_tree: = get_tree()
export(String, FILE) var next_scene_path = ""

func _on_button_up():
	PlayerData.reset()
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning() -> String:
	return "next_scene_path must be set for the button to work" if next_scene_path == "" else ""

func _on_Title_button_down():
	pass # Replace with function body.



