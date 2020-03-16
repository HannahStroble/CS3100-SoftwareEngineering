extends KinematicBody2D
class_name Actor
const FLOOR_NORMAL: = Vector2.UP
export var speed: = Vector2(150.0, 150.0)
export var gravity: = 4000.0
var _velocity: = Vector2.ZERO

func _physics_process(delta: float) -> void:
			_velocity.y += gravity * delta


