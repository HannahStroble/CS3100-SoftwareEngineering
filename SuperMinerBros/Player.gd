extends KinematicBody2D

const SPEED = 60
const GRAVITY = 10
const JUMP_POWER = -250
const FLOOR = Vector2(0,-1)
const FIRABALL = preload("res://Fireball.tscn")

var velocity = Vector2()
var on_ground = false


func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		if Input.is_key_pressed(KEY_SHIFT):
			velocity.x = SPEED * 2
			$Sprite/AnimationPlayer.play("Running")
		else:
			velocity.x = SPEED
			$Sprite/AnimationPlayer.play("Walking")
			
		$Sprite.flip_h = false
		
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
			
	elif Input.is_action_pressed("ui_left"):
		if Input.is_key_pressed(KEY_SHIFT):
			velocity.x = -SPEED * 2
			$Sprite/AnimationPlayer.play("Running")
		else:
			velocity.x = -SPEED
			$Sprite/AnimationPlayer.play("Walking")
			
		$Sprite.flip_h = true
		
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	else:
		velocity.x = 0
		if on_ground == true:
			$Sprite/AnimationPlayer.play("idle")
		
	if Input.is_action_pressed("ui_up"):
		if on_ground == true:
			velocity.y = JUMP_POWER
			on_ground = false
	if Input.is_action_just_pressed("ui_accept"):
		var fireball = FIRABALL.instance()
		
		if sign($Position2D.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
			
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
	velocity.y += GRAVITY
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
		if velocity.y < 0:
			$Sprite/AnimationPlayer.play("Jump")
		else:
			$Sprite/AnimationPlayer.play("fall")
	
		
	velocity = move_and_slide(velocity, FLOOR)