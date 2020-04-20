extends StaticBody2D

var possible_sprites = [preload("res://scenary/sprites/árbol.png"), 
						preload("res://scenary/sprites/árbol2.png"),
						preload("res://scenary/sprites/árbol3.png")]

func _ready():
	randomize()
	set_rotation(randi() % 360)
	$Sprite.texture = possible_sprites[randi() % possible_sprites.size()]
