extends Node2D

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
			var throwing_vector = get_global_mouse_position() - _throwing_object.get_global_position()
			_throwing_object.impulse(10*throwing_vector)
			_throwing_object = null
			

func select_object(throwable):
	selected_objects.append(throwable)

func deselect_object(throwable):
	selected_objects.erase(throwable)
