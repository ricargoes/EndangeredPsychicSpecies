extends KinematicBody2D

var carrying = true
var max_speed = 150.0

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_just_pressed("carrier_dash"):
		try_dashing()
	if Input.is_action_just_pressed("carrier_grab") and not carrying:
		grab()
	
	var movement_dir = Vector2.ZERO
	if Input.is_action_pressed("carrier_move_up"):
		movement_dir += Vector2.UP
	if Input.is_action_pressed("carrier_move_down"):
		movement_dir += Vector2.DOWN
	if Input.is_action_pressed("carrier_move_right"):
		movement_dir += Vector2.RIGHT
	if Input.is_action_pressed("carrier_move_left"):
		movement_dir += Vector2.LEFT
	
	var speed = max_speed*3/4.0*movement_dir.normalized()
	if carrying:
		speed *= 3/4.0
	
	if movement_dir != Vector2.ZERO:
		set_rotation(movement_dir.angle())
	move_and_slide(speed)
	if speed == Vector2.ZERO:
		$Sprite.play("standing")
	else:
		if carrying:
			$Sprite.play("running_alien")
		else:
			$Sprite.play("running")

func try_dashing():
	pass

func grab():
	pass
