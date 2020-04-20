extends AudioStreamPlayer

var normal_theme_pos = 0

func play_freedom():
	normal_theme_pos = get_playback_position()
	stream = preload("res://music/Tema2.ogg")
	play()

func play_normal_theme():
	stream = preload("res://music/Tema1.ogg")
	play(normal_theme_pos)
