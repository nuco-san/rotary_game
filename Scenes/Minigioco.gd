extends Node2D


var score := 0


func _ready():
	Global.connect("track_filled", self, "_on_track_filled")


func _on_track_filled(correctly):
	if correctly:
		score += 1
	else:
		score -= 1
	if score == 8:
		score = 0
		Global.increase_round()
