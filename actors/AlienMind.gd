extends Node

var selected_objects = []
var _throwing_object = null

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("alien_grab_object"):
		if selected_objects:
			_throwing_object = selected_objects.pop_front()
	elif event.is_action_released("alien_grab_object"):
		if _throwing_object:
			var throwing_vector = get_viewport().get_mouse_position() - _throwing_object.get_global_position()
			var strength = min(throwing_vector.length(), 500)/500.0
			_throwing_object.impulse(3*throwing_vector)
			

func select_object(throwable):
	selected_objects.append(throwable)

func deselect_object(throwable):
	selected_objects.erase(throwable)
