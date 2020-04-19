extends StaticBody2D


func hit():
	$Fine.hide()
	$Broken.show()
	$Broken.play("default")
	$Trap.active = true
