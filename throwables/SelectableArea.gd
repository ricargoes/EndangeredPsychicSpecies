extends Area2D


func _on_SelectableArea_mouse_entered():
	AlienMind.select_object(get_parent())


func _on_SelectableArea_mouse_exited():
	AlienMind.deselect_object(get_parent())

