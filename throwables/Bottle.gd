extends "res://throwables/ThrowableObject.gd"

var possible_sprites = [preload("res://throwables/sprites/botellaverde.png"), preload("res://throwables/sprites/botellaazul.png")]

func _ready():
	randomize()
	set_rotation(randi() % 360)
	$Sprite.texture = possible_sprites[randi() % possible_sprites.size()]
	$Hit.stream = preload("res://sfx/breaking glass.wav")

