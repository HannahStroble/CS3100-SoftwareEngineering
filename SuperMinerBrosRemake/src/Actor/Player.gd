extends Actor
export var stomp_impulse := 300.00

func _on_HitBox_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_HurtBox_body_entered(body):
	queue_free()
	
func _physics_process(delta: float) -> void:
	var direction: = get_dir()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

#Added move_right, move_left, and jump
#TODO: flip the sprite.
func get_dir() -> Vector2:
	return  Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

#pure func no mutation only calculation
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
	) -> Vector2:

	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	return new_velocity


func calculate_stomp_velocity(
		linear_velocity: Vector2,
		impulse: float
	) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out
	








