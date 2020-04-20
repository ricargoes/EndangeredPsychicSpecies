extends Control

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	elif event.is_action_pressed("ui_accept"):
		State.city = "res://level/Level.tscn"
		get_tree().change_scene(State.city)
	elif event.is_action_pressed("ui_accept_other"):
		State.city = "res://level/ProcGenLevel.tscn"
		get_tree().change_scene(State.city)
