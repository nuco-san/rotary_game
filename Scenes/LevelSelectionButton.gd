extends Button

export(int) var minigame_number

signal minigame_selected



func _on_LevelSelectionButton_pressed():
	emit_signal("minigame_selected", minigame_number)
