extends Control

func _ready():
	if State.alien_wins:
		_alien_wins()
	else:
		_carrier_wins()
	
	set_process_input(true)

func _input(event):
	if not $SettleDownTimer.is_stopped():
		return
	
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	elif event.is_action_type():
		get_tree().change_scene("res://level/Level.tscn")

func _alien_wins():
	$VBoxContainer/Who.text = "Alien wins"
	$VBoxContainer/HBoxContainer/Descrption.text = "The baby alien gets killed while exploring the world. Well, at least he died FREE!"
	$VBoxContainer/HBoxContainer/Picture.texture = preload("res://actors/sprites/creaturecrawling2.png")

func _carrier_wins():
	$VBoxContainer/Who.text = "Frank wins"
	$VBoxContainer/HBoxContainer/Descrption.text = "Frank manages to keep the alien alive desite its best efforts. The alien is not mature enough to know the world is dangerous. Frank knows best."
	$VBoxContainer/HBoxContainer/Picture.texture = preload("res://actors/sprites/daddystanding_reloj4.png")