extends "res://throwables/ThrowableObject.gd"

var is_empty = false

func own_damage():
	if not is_empty:
		var bag = preload("res://throwables/GarbageBag.tscn").instance()
		var bottle = preload("res://throwables/Bottle.tscn").instance()
		bag.set_position(get_position()+Vector2(0, 50))
		bottle.set_position(get_position()+Vector2(50, 0))
		get_parent().add_child(bag)
		get_parent().add_child(bottle)
		is_empty = true
	.own_damage()
