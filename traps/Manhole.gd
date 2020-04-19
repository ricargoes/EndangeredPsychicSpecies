extends "res://traps/Trap.gd"

func _on_ThrowableObject_sleeping_state_changed():
	activate()
