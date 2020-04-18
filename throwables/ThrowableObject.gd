extends RigidBody2D

func impulse(force):
	add_force(Vector2.ZERO, force)
	$ImpulseTime.start()


func _on_ImpulseTime_timeout():
	set_applied_force(Vector2.ZERO)
