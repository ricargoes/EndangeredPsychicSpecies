extends StaticBody2D


func hit():
	$Fine.hide()
	$Broken.show()
	$Broken.play("default")
	if has_node("Trap"):
		$Trap.activate()
