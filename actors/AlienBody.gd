extends KinematicBody2D

var max_speed = 230

func _ready():
	set_process(true)

func _process(delta):
	var destination = null
	if Input.is_action_pressed("alien_set_destination"):
		destination = get_global_mouse_position()
		var vector_to_dest = destination - get_position()
		if vector_to_dest.length() > 20:
			set_rotation(vector_to_dest.angle())
			move_and_slide(vector_to_dest.normalized()*max_speed, Vector2.ZERO, false, 4, PI/4, false)
			$Sprite.play("crawling")
		else:
			$Sprite.play("standing")
	else:
		$Sprite.play("standing")

func hit():
	if $Invulnerability.is_stopped():
		State.alien_wins()
		
