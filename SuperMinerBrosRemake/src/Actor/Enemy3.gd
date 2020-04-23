extends "res://src/Actor/Actor.gd"

onready var sprite: Sprite = get_node("enemy")
export var score: = 100
var down_count = 0
func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	if sprite.frame == 8:
		down_count += 1
		if down_count == 64:
			sprite.frame = 0
			down_count = 0
		return
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
			call_deferred("get_node","disabled", true)
			if sprite.frame == 0:
				sprite.frame = 8
				
			elif sprite.frame == 8:
				queue_free()
			PlayerData.score += score
	return

func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
