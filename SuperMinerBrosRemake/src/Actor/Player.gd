extends Actor

export var stomp_impulse := 500.00
export var max_health := 75.0 # 25.0 small, 50.0 big, 75.0 powerup
onready var invulnerability_timer = $InvulnerabilityTimer
onready var animation = $AnimationPlayer
onready var camera = $Camera2D
var powerUpSpeedBonus = 1
var time_dec = 16
onready var Sound_FX = get_node("AudioPlayer")
onready var Jump_Sound_fx = load("res://Assets/Sounds/Player_Jump.wav")
onready var Death_Sound_fx = load("res://Assets/Sounds/Death_Sound_Player.wav")
var sound_done = false

onready var dino = get_node("dino")
var time_dec = 32


func _ready():
	size()

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_bit(1) == true:
		_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_ED2_body_entered(body):
	if invulnerability_timer.is_stopped() == false:
		body.queue_free()
	elif body.get_filename().get_file() == "Enemy0.tscn":
		shrink()
	elif body.get_filename().get_file() == "Enemy1.tscn":
		shrink()
	elif body.get_filename().get_file() == "Enemy2.tscn":
		shrink()
	elif body.get_filename().get_file() == "Enemy3.tscn":
		shrink()
	elif body.get_filename().get_file() == "Enemy4.tscn":
		shrink()
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	PlayerData.lives -= 1

func _on_InvulnerabilityTimer_timeout():
	animation.play("Idle")
	
func _physics_process(delta: float) -> void:
	var direction: = get_dir()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

	if direction.y == -1.0:
		sound_done = Sound_FX._play_sound(Jump_Sound_fx)

	if PlayerData.power_up == true and Input.is_action_just_pressed("shoot"):
		self.gravity *= -1
	if direction.x == 1 and _velocity.x != 0:
		camera.limit_left += 2
	if time_dec == 0:
		PlayerData.time -= 1
		if PlayerData.time == 0:
			queue_free()
		time_dec = 32
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

func damage(amount):
	if PlayerData.health - amount <= 0:
		#sound_done = Sound_FX._play_sound(Death_Sound_fx)
func grow():
	self.scale.y *= 2

func shrink():
	if invulnerability_timer.is_stopped() == false:
		return
	if PlayerData.size == 1:#small
		queue_free()
		PlayerData.deaths += 1
	elif PlayerData.size == 2:#large
		PlayerData.size = 1
		self.scale.y *= .5
		invulnerability_timer.start()
		animation.play("I-Frame")
	elif PlayerData.size == 3:#powerup
		PlayerData.power_up = false
		PlayerData.size = 2
		invulnerability_timer.start()
		animation.play("I-Frame")
	
	
func iframes():
	invulnerability_timer.set_wait_time(3.97)
	invulnerability_timer.start()
	animation.play("Star")
	
func size():
	if PlayerData.size == 2 or PlayerData.size == 3:
		self.scale.y *= 2
	
