extends "res://src/Actor/Actor.gd"

#get AudioPlayer Node on game start
onready var AudioPlayer = get_node("AudioPlayer")
#Load Sound
onready var Hit_Sound_fx = load("res://Assets/Sounds/mob_sounds/Skeleton_hit.wav")
onready var sprite = get_node("enemy")
onready var Shape2d: CollisionShape2D = get_node("EHit")
onready var HurtBox: Area2D = get_node("HurtBox")
func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

export var score: = 100
var sound_done = false

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
		
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func _on_HurtBox_area_entered(area):
	if sound_done == true:
		queue_free()
		return
	if area != null:
		if area.position.y >= get_node("HurtBox").position.y and area.name == "EnemyDetector":
			sound_done = AudioPlayer._play_sound(Hit_Sound_fx)
			sprite.visible = false
			HurtBox.set_collision_layer_bit(1,false)
			call_deferred("get_node","disabled", true)
			PlayerData.score += score
	return
