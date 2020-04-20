extends StaticBody2D

var possible_sprites = [preload("res://scenary/sprites/car1.png"),
						preload("res://scenary/sprites/coche4.png")]

func _ready():
	randomize()
	$Sprite.texture = possible_sprites[randi() % possible_sprites.size()]
