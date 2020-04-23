extends Control

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_Tutorial_pressed():
	pass # Replace with function body.


func _on_Rush_pressed():
	get_tree().change_scene("res://level/LevelRush.tscn")


func _on_Standard_pressed():
	get_tree().change_scene("res://level/LevelStandard.tscn")


func _on_Large_pressed():
	get_tree().change_scene("res://level/LevelLarge.tscn")


func _on_Quit_pressed():
	get_tree().quit()
