extends StaticBody2D

var possible_sprites = [preload("res://scenary/sprites/arbol.png"), 
						preload("res://scenary/sprites/arbol2.png"),
						preload("res://scenary/sprites/arbol3.png")]

func _ready():
	randomize()
	set_rotation(randi() % 360)
	$Sprite.texture = possible_sprites[randi() % possible_sprites.size()]
