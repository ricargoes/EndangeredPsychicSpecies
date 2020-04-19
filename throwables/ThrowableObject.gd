extends RigidBody2D

func impulse(force):
	add_force(Vector2.ZERO, force)
	$ImpulseTime.start()

func _on_ImpulseTime_timeout():
	set_applied_force(Vector2.ZERO)

func _on_ThrowableObject_body_entered(body):
	$Hit.play(0.25)
	if body.has_method("hit"):
		body.hit()

func _on_ThrowableObject_sleeping_state_changed():
	if not sleeping:
		contact_monitor = true
		contacts_reported = 3

func _on_SelectableArea_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("alien_grab_object"):
		get_tree().call_group("alien_mind", "grab_object", self)
