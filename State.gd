extends Node

var alien_wins = false

func alien_wins():
	alien_wins = true
	get_tree().change_scene("res://level/GameOver.tscn")

func carrier_wins():
	alien_wins = false
	get_tree().change_scene("res://level/GameOver.tscn")
