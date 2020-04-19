extends RigidBody2D

func impulse(force):
	add_force(Vector2.ZERO, force)
	$ImpulseTime.start()

func _on_ImpulseTime_timeout():
	set_applied_force(Vector2.ZERO)

func _on_SelectableArea_mouse_entered():
	get_tree().call_group("alien_mind", "select_object", self)

func _on_SelectableArea_mouse_exited():
	get_tree().call_group("alien_mind", "deselect_object", self)

func _on_ThrowableObject_body_entered(body):
	if body.is_in_group("actor"):
		body.hit()

func _on_ThrowableObject_sleeping_state_changed():
	if not sleeping:
		contact_monitor = true
		contacts_reported = 3
