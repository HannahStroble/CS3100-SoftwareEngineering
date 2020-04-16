extends Control

onready var scene_tree: = get_tree()
onready var paused_overlay: ColorRect = get_node("PauseOverlay")
onready var time: Label = get_node("Label4")
onready var score: Label = get_node("Label3")
onready var coins: Label = get_node("Label2")
onready var lives: Label = get_node("Label")
onready var pause_title: Label = get_node("PauseOverlay/Title")
onready var main_menu: Button = get_node("PauseOverlay/PauseMenu/ChangeSceneButtion")
onready var retry: Button = get_node("PauseOverlay/PauseMenu/Retry")
var paused: = false setget set_paused

func _ready() -> void:
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	PlayerData.connect("coins_updated", self, "update_interface")
	PlayerData.connect("lives_updated", self, "update_interface")
	PlayerData.connect("time_updated", self, "update_interface")
	main_menu.next_scene_path = "res://src/Screen/MainScreen.tscn"
	update_interface()
	
func _on_PlayerData_player_died() -> void:
	self.paused = true
	PlayerData.lives -= 1
	if PlayerData.lives == 0:
		pause_title.text = "Game Over"
		retry.set_disabled(true)
	elif PlayerData.time == 0:
		pause_title.text = "Game Over"
	else:
		pause_title.text = "You Died"
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("paused") and pause_title.text != "You Died":
		self.paused = not paused
		scene_tree.set_input_as_handled()

func update_interface() -> void:
	score.text = "Score: %s" % PlayerData.score
	coins.text = "Coins: %s" % PlayerData.coins
	lives.text = "Lives: %s" % PlayerData.lives
	time.text  = "Time: %s" % PlayerData.time
	
func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	paused_overlay.visible = value