extends Node2D


var time_left := 600
var current_minigame := 0
var current_round := 1

signal track_filled
signal timer_updated
signal round_updated


func _ready():
	next_minigame()


func next_minigame():
	current_round = 1
	current_minigame += 1
	$LevelTimer.start()


func increase_round():
	get_tree().change_scene("res://Scenes/Minigioco_1.tscn")
	current_round += 1
	emit_signal("round_updated", current_round)


func _on_LevelTimer_timeout():
	time_left -= 1
	emit_signal("timer_updated", time_left)
	if time_left <= 0:
		next_minigame()

