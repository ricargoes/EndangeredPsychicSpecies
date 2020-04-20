extends KinematicBody2D

var max_speed = 230

func _ready():
	set_process(true)

func _process(delta):
	var destination = null
	if Input.is_action_pressed("alien_set_destination"):
		destination = get_global_mouse_position()
		var pos = get_position()
		var points_to_destination = get_tree().get_nodes_in_group("navigation")[0].get_simple_path(get_position(), destination)
		var vector_to_next = points_to_destination[1] - get_position()
		if points_to_destination[-1] != points_to_destination[1] or vector_to_next.length() > 20:
			set_rotation(vector_to_next.angle())
			move_and_slide(vector_to_next.normalized()*max_speed, Vector2.ZERO, false, 4, PI/4, false)
			$Sprite.play("crawling")
		else:
			$Sprite.play("standing")
	else:
		$Sprite.play("standing")

func hit():
	if $Invulnerability.is_stopped():
		State.alien_wins()
		
