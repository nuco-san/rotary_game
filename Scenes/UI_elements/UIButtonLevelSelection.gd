extends Button

export(int) var minigame_number

signal minigame_selected


func _ready():
	$AnimationPlayer.play("underline_anim")


func _on_LevelSelectionButton_pressed():
	$AudioStreamPlayer.play()
	emit_signal("minigame_selected", minigame_number)
