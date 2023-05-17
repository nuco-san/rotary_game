extends Node2D


var current_minigame := 1
var current_round := 1

signal track_filled
signal timer_updated
signal round_updated


func next_minigame():
	current_round = 1
	if current_minigame == 3:
		get_tree().change_scene("res://Scenes/TItleScreen.tscn")
		current_minigame = 1
	else:		
		current_minigame += 1
		get_tree().change_scene("res://Scenes/Minigiochi/Minigioco_" + str(current_minigame) + ".tscn")


func increase_round():
	current_round += 1


func load_minigame(number):
	get_tree().change_scene("res://Scenes/Minigiochi/Minigioco_" + str(number) + ".tscn")
	current_minigame = number




