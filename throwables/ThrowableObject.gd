extends RigidBody2D

export var breakable = false

func impulse(force):
	add_force(Vector2.ZERO, force)
	$ImpulseTime.start()

func PsychicGrabFeedback(enable=true):
	if enable:
		$AnimationPlayer.play("psychic_feedback")
	else:
		$AnimationPlayer.stop()

func _on_ImpulseTime_timeout():
	set_applied_force(Vector2.ZERO)

func _on_ThrowableObject_body_entered(body):
	if body.has_method("hit"):
		body.hit()
	
	own_damage()

func _on_ThrowableObject_sleeping_state_changed():
	if not sleeping:
		contact_monitor = true
		contacts_reported = 3

func _on_SelectableArea_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("alien_grab_object"):
		get_tree().call_group("alien_mind", "grab_object", self)

func own_damage():
	if breakable:
		State.play_sound($Hit.stream)
		queue_free()
	else:
		$Hit.play(0.25)
