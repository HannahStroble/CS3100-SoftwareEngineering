extends "res://src/Actor/Actor.gd"

#onready var Coin_Sound_fx = load("res://Assets/Sounds/CoinSound_2.wav")
onready var Sound_FX = get_node("AudioPlayer")
onready var Hit_Sound_fx = load("res://Assets/Sounds/slime_hit.wav")
onready var sprite = get_node("enemy")
onready var Shape2d: CollisionShape2D = get_node("EHit")
onready var HurtBox: Area2D = get_node("HurtBox/CollisionShape2D")

#onready var sprite: Sprite = get_node("enemy")
export var score: = 100
var sound_done = false

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	if sprite.frame == 8:
		return
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func _on_HurtBox_area_entered(area):
	if area != null:
		if area.position.y >= get_node("HurtBox").position.y and area.name == "EnemyDetector":
			call_deferred("get_node","disabled", true)
			sound_done = Sound_FX._play_sound(Hit_Sound_fx)
			if sprite.frame == 0:
				sprite.frame = 8
				
			elif sprite.frame == 8:
				if sound_done == true:
					queue_free()
					return
				
			sprite.visible = false
			Shape2d.disabled = true
			HurtBox.visible = false
			Shape2d.visible = false	
			
			PlayerData.score += score
	return
