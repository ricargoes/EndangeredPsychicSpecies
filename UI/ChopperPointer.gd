extends Node2D

var choppers = []

func _ready():
	choppers = get_tree().get_nodes_in_group("helicopters")

func register_chopper(chopper):
	choppers.append(chopper)

func show_pointer():
	show()
	set_process(true)

func hide_pointer():
	hide()
	set_process(false)
	
func _process(delta):
	for chopper in choppers:
		var dir = chopper.get_global_position() - get_global_position()
		set_global_rotation(dir.angle())
