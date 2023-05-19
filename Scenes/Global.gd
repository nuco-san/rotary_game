extends Node2D

var minigame_duration := 60
var current_minigame := 1
var current_round := 1
enum game_modes {STORY, SELECTION}
var current_game_mode = game_modes.STORY

signal track_filled
signal too_much_food
signal timer_updated
signal round_updated
signal tick_item
signal untick_item



func next_minigame():
	current_round = 1
	if current_game_mode == game_modes.STORY:
		if current_minigame == 3:
			get_tree().change_scene("res://Scenes/TItleScreen.tscn")
			current_minigame = 1
		else:
			current_minigame += 1
			get_tree().change_scene("res://Scenes/Minigiochi/Minigioco_" + str(current_minigame) + ".tscn")
	if current_game_mode == game_modes.SELECTION:
		get_tree().change_scene("res://Scenes/TItleScreen.tscn")


func increase_round():
	current_round += 1


func load_minigame(number):
	get_tree().change_scene("res://Scenes/Minigiochi/Minigioco_" + str(number) + ".tscn")
	current_minigame = number




