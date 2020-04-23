extends Node
signal score_updated
signal player_died
signal lives_updated
signal coins_updated
signal time_updated
signal size_updated
signal power_updated
#any script in program can access this
#setting up a setter function
var score: = 0 setget set_score
var deaths: = 0 setget set_death
var lives: = 2 setget set_lives
var coins: = 0 setget set_coins
var time: = 365 setget set_time
var bonus_lives: = 1 setget set_bonus_lives
var size: = 1 setget set_size
var power_up = false setget set_power
func reset() -> void:
	time = 365

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")
	return

func set_death(value: int) -> void:
	deaths = value
	emit_signal("player_died")

func set_lives(value: int) -> void:
	lives = value
	emit_signal("lives_updated")

func set_coins(value: int) -> void:
	coins = value
	emit_signal("coins_updated")

func set_time(value: int) -> void:
	time = value
	emit_signal("time_updated")

func set_bonus_lives(value: int) -> void:
	bonus_lives = value
	emit_signal("lives_updated")

func set_size(value: int) -> void:
	size = value
	emit_signal("size_updated")
	
func set_power(value: bool) ->void:
	power_up = value
	emit_signal("power_updated")
