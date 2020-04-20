extends KinematicBody2D

var carrying = true
var max_speed = 300.0
var dashing_dir = Vector2.RIGHT

func _ready():
	set_process(true)

func _process(delta):
	if $Dash.is_stopped():
		var movement_dir = Vector2.ZERO
		
		if $StunCooldown.is_stopped():
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
			if not $Walking.playing:
				$Walking.play()
		else:
			$Walking.stop()
		move_and_slide(speed, Vector2.ZERO, false, 4, PI/4, false)
		if movement_dir == Vector2.ZERO:
			if carrying:
				$Sprite.play("standing_alien")
			else:
				$Sprite.play("standing")
		else:
			if carrying:
				$Sprite.play("running_alien")
			else:
				$Sprite.play("running")
	else:
		move_and_slide(dashing_dir*max_speed*2)
		if carrying:
			$Sprite.play("dashing_alien")
		else:
			$Sprite.play("dashing")

func try_dashing():
	if $DashCooldown.is_stopped():
		$Dash.start()
		$DashCooldown.start()
		dashing_dir = Vector2(cos(get_rotation()), sin(get_rotation()))

func grab():
	if carrying:
		return
	
	var aliens = get_tree().get_nodes_in_group("alien")
	if aliens:
		var alien = aliens.front()
		if (alien.get_position() - get_position()).length() < 50:
			alien.queue_free()
			carrying = true
			var music = get_tree().get_nodes_in_group("music")[0]
			music.stream = preload("res://music/Tema1.ogg")
			music.play()

func hit():
	stun()
	if carrying:
		drop_alien()

func drop_alien():
	carrying = false
	spawn_alien()
	get_tree().call_group("traps", "mark", true)
	var music = get_tree().get_nodes_in_group("music")[0]
	music.stream = preload("res://music/Tema2.ogg")
	music.play()

func stun():
	$StunCooldown.start()
	$HeadStars.emitting = true

func _on_StunCooldown_timeout():
	$HeadStars.emitting = false

func spawn_alien():
	var alien = preload("res://actors/AlienBody.tscn").instance()
	alien.set_position(get_position())
	get_parent().add_child(alien)
