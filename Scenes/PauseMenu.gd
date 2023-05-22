extends Node2D

var pressed_buttons_number := 0


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$PauseMenuPanel.show()
		get_tree().paused = true



func pause_button_pressed():
	pressed_buttons_number += 1
	if pressed_buttons_number == 4:
		pressed_buttons_number = 0
		$PauseMenuPanel.show()
		get_tree().paused = true


func pause_button_released():
	pressed_buttons_number -= 1


func resume():
	get_tree().paused = false
	$PauseMenuPanel.hide()
