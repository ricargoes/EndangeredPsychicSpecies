extends Timer

func _ready():
	set_process(true)

func _process(delta):
	var time_consumed = 1 - time_left / float(wait_time)
	var alpha = pow(time_consumed, 6)
	$CanvasLayer/Heat.modulate = Color(0.8, 0, 0, alpha)

func _on_Countdown_timeout():
	State.alien_wins()
