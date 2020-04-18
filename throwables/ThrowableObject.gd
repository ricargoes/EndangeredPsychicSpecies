extends RigidBody2D

func impulse(force):
	add_force(Vector2.ZERO, force)
	$ImpulseTime.start()

func _on_ImpulseTime_timeout():
	set_applied_force(Vector2.ZERO)

func _on_SelectableArea_mouse_entered():
	AlienMind.select_object(self)

func _on_SelectableArea_mouse_exited():
	AlienMind.deselect_object(self)
	
func _on_ThrowableObject_sleeping_state_changed():
	if not sleeping:
		contact_monitor = true
		contacts_reported = 3
