extends Node2D

export(NodePath) var score_label_path
onready var score_label : Label = get_node(score_label_path)


var score := 0


func _ready():
	Global.connect("track_filled", self, "_on_track_filled")


func _on_track_filled(correctly):
	if correctly:
		score += 1
	else:
		score -= 1
	score_label.text = str(score)
