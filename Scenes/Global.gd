extends Node2D


var current_minigame := 0
var current_round := 1

signal track_filled
signal timer_updated
signal round_updated


func next_minigame():
	current_round = 1
	current_minigame += 1


func increase_round():
	current_round += 1







