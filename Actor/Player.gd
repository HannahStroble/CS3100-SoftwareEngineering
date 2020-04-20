extends Actor

signal health_updated()
export var stomp_impulse := 500.00
export var max_health := 75.0 # 25.0 small, 50.0 big, 75.0 powerup
onready var invulnerability_timer = $InvulnerabilityTimer
onready var animation = $AnimationPlayer
onready var camera = $Camera2D
var powerUpSpeedBonus = 1
var time_dec = 16


func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	if area.name == "HurtBox":
		_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_ED2_body_entered(body):
	if body.get_filename().get_file() == "Enemy0.tscn":
		damage(25.0)
	elif body.get_filename().get_file() == "Enemy1.tscn":
		damage(25.0)
	elif body.get_filename().get_file() == "Enemy2.tscn":
		damage(25.0)

func _on_VisibilityNotifier2D_screen_exited():
	damage(1000)


func _physics_process(delta: float) -> void:
	var direction: = get_dir()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

	if direction.x == 1 and _velocity.x != 0:
		camera.limit_left += 1
	if time_dec == 0:
		PlayerData.time -= 1
		if PlayerData.time == 0:
			damage(1000)
		time_dec = 16
	time_dec -= 1
	
#Added move_right, move_left, and jump
#TODO: flip the sprite.
func get_dir() -> Vector2:
	return  Vector2(
		#left = -1 and right = 1 on the x axis
		.025 if camera.limit_left > self.position.x
		else Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		#ternary op if 
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)


#pure func no mutation only calculation
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
	) -> Vector2:

	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x * powerUpSpeedBonus
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

func damage(amount):
	if PlayerData.health - amount <= 0:
		queue_free()
		PlayerData.deaths += 1
		print(PlayerData.health)
	elif invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		PlayerData.health -= amount
		animation.play("I-Frame")
		
func _set_health(value):
	var prev_health
	var health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
			
func oneUpc1():
	_set_health(max_health)
	PlayerData.lives += 1
	
func oneUpc2():
	_set_health(max_health)
	PlayerData.lives += 1
	
func powerUpc1():
	powerUpSpeedBonus = powerUpSpeedBonus + 1
	
func powerUpc2():
	powerUpSpeedBonus = powerUpSpeedBonus + 1.5
	
func mysteryBox():
	powerUpSpeedBonus = powerUpSpeedBonus + 5
	
func starc1():
	pass
	
func starc2():
	pass
	



