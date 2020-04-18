extends KinematicBody2D

var carrying = true
var stunned = false
var max_speed = 150.0

func _ready():
	set_process(true)

func _process(delta):
	var movement_dir = Vector2.ZERO
	
	if not stunned:
		if Input.is_action_just_pressed("carrier_dash"):
			try_dashing()
		if Input.is_action_just_pressed("carrier_grab") and not carrying:
			grab()
		
		if Input.is_action_pressed("carrier_move_up"):
			movement_dir += Vector2.UP
		if Input.is_action_pressed("carrier_move_down"):
			movement_dir += Vector2.DOWN
		if Input.is_action_pressed("carrier_move_right"):
			movement_dir += Vector2.RIGHT
		if Input.is_action_pressed("carrier_move_left"):
			movement_dir += Vector2.LEFT
		
	var speed = max_speed*movement_dir.normalized()
	if carrying:
		speed *= 3/4.0
	
	if movement_dir != Vector2.ZERO:
		set_rotation(movement_dir.angle())
	move_and_slide(speed, Vector2.ZERO, false, 4, PI/4, false)
	if movement_dir == Vector2.ZERO:
		$Sprite.play("standing")
	else:
		if carrying:
			$Sprite.play("running_alien")
		else:
			$Sprite.play("running")

func try_dashing():
	pass

func grab():
	if carrying:
		return
	
	var aliens = get_tree().get_nodes_in_group("alien")
	if aliens:
		var alien = aliens.front()
		if (alien.get_position() - get_position()).length() < 50:
			alien.queue_free()
			carrying = true

func hit():
	stun()
	if carrying:
		carrying = false
		spawn_alien()

func stun():
	$StunCooldown.start()
	$HeadStars.emitting = true
	stunned = true

func _on_StunCooldown_timeout():
	stunned = false
	$HeadStars.emitting = false

func spawn_alien():
	var alien = preload("res://actors/AlienBody.tscn").instance()
	alien.set_position(get_position())
	get_parent().add_child(alien)
