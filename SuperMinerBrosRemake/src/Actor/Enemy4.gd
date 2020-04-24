extends "res://src/Actor/Actor.gd"

#get AudioPlayer Node on game start
#Load Sound
onready var sprite: Sprite = get_node("ghost")
onready var HurtBox: Area2D = get_node("HurtBox")
onready var timer = get_node("FireBallTimer")
const FIREBALL = preload("res://src/Objects/Fireball.tscn")

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

export var score: = 100

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
		if sprite.flip_h == true:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func _on_HurtBox_area_entered(area):
	if area != null:
		if area.position.y >= get_node("HurtBox").position.y and area.name == "EnemyDetector":
			queue_free()
			call_deferred("get_node","disabled", true)
			PlayerData.score += score
	return


func _on_FireBallTimer_timeout():
	var fireball = FIREBALL.instance()
	fireball.set_fireball_direction(_velocity.x)
	get_parent().add_child(fireball)
	fireball.position = $Position2D.global_position

func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
