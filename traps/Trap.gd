extends Area2D

var color_mark_disable = Color(0, 0.5, 0, 0)
var color_mark_enable = Color(0, 0.5, 0, 0.5)

func _ready():
	mark(false)

func mark(enable):
	if enable:
		$Marker.self_modulate = color_mark_enable
	else:
		$Marker.self_modulate = color_mark_disable

func _on_Trap_body_entered(body):
	body.hit()
