extends StaticBody2D

export var broken = false

func _ready():
	if broken:
		hit()

func hit():
	broken = true
	$Fine.hide()
	$Broken.show()
	$Broken.play("default")
	if has_node("Trap"):
		$Trap.activate()
