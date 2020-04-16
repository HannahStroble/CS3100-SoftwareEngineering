tool
extends Button

export(String, FILE) var FILE_PATH = ""

func _on_button_up():
	get_tree().change_scene(FILE_PATH)

func _get_configuration_warning() -> String:
	return "FILE_PATH must be set for the button to work" if FILE_PATH == "" else ""
