extends Area2D

func _on_Goal_body_entered(body):
	if body.is_in_group("actor"):
		carrier_wins()

func carrier_wins():
	State.alien_wins = false
	get_tree().change_scene("res://level/Goal.tscn")
