extends "res://src/Actor/Actor.gd"
func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

export var score: = 100



func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
		
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func _on_HurtBox_area_entered(area):
	if area != null:
		if area.position.y >= get_node("HurtBox").position.y and area.name == "EnemyDetector":
			call_deferred("get_node","disabled", true)
			queue_free()
			PlayerData.score += score
	return
