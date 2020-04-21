extends "res://src/Actor/Actor.gd"

onready var sprite: Sprite = get_node("enemy")
export var score: = 100
var jumping = true

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x
	
func _physics_process(delta: float) -> void:
	
	_velocity.y += gravity * delta
	if is_on_floor() and jumping == true:
		_velocity.y = -1*speed.y
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	
	
func _on_HurtBox_area_entered(area):
	if area != null:
		if area.position.y >= get_node("HurtBox").position.y and area.name == "EnemyDetector":
			if jumping == true:
				jumping = false	
			elif sprite.frame == 0:
				sprite.frame = 1
			elif sprite.frame == 1:
				call_deferred("get_node","disabled", true)
				queue_free()
			PlayerData.score += score
	return