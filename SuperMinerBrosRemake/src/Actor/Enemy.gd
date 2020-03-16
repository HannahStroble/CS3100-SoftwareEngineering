extends "res://src/Actor/Actor.gd"
func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

func _on_HurtBox_body_entered(body: PhysicsBody2D) -> void:
	if body.position.y > get_node("HurtBox").position.y:
		print(body.name)
		get_node("CollisionShape2D").disabled = true
		queue_free()
	return
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
		
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
