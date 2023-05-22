extends Node2D

var minigame_duration := 5
var current_minigame := 1
var current_round := 1
enum game_modes {STORY, SELECTION}
var current_game_mode = game_modes.STORY
var total_score = 0
var partial_score = 0


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
			get_tree().change_scene("res://Scenes/FinalScreen.tscn")
		else:
			current_minigame += 1
			get_tree().change_scene("res://Scenes/Minigiochi/Minigioco_" + str(current_minigame) + ".tscn")
	if current_game_mode == game_modes.SELECTION:
		get_tree().change_scene("res://Scenes/FinalScreen.tscn")


func increase_round():
	current_round += 1
	partial_score += 1


func load_minigame(number):
	get_tree().change_scene("res://Scenes/Minigiochi/Minigioco_" + str(number) + ".tscn")
	current_minigame = number


func update_total_score():
	total_score += partial_score
	partial_score = 0


func restart_game():
	get_tree().change_scene("res://Scenes/TItleScreen.tscn")
	current_minigame = 1
	current_round = 1
	current_game_mode = game_modes.STORY
	total_score = 0
	partial_score = 0


