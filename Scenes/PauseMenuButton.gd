extends TouchScreenButton

export(int) var button_id

signal pause_button_pressed
signal pause_button_released

func _on_PauseMenuButton_pressed():
	emit_signal("pause_button_pressed", button_id)


func _on_PauseMenuButton_released():
	emit_signal("pause_button_released", button_id)
