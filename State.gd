extends Node

var alien_wins = false

var city = null

func alien_wins():
	alien_wins = true
	get_tree().change_scene("res://level/GameOver.tscn")

func carrier_wins():
	alien_wins = false
	get_tree().change_scene("res://level/GameOver.tscn")

func play_sound(stream):
	var sfx_players = get_tree().get_nodes_in_group("sfx")
	for player in sfx_players:
		if not player.playing:
			player.stream = stream
			player.play()
