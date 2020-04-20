extends Node
signal score_updated
signal player_died
signal lives_updated
signal coins_updated
signal time_updated
signal set_health
#any script in program can access this
#setting up a setter function
var score: = 0 setget set_score
var deaths: = 0 setget set_death
var lives: = 2 setget set_lives
var coins: = 0 setget set_coins
var time: = 365 setget set_time
var bonus_lives: = 1 setget set_bonus_lives
var health = 25 setget set_health

func reset() -> void:
	score = 0
	deaths = 0
	lives = 2
	coins = 0
	time = 365
	bonus_lives = 1
	health = 25

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
	emit_signal("bonus_lives_updated")

func set_health(value: int) -> void:
	health = value
	emit_signal("health_updated")