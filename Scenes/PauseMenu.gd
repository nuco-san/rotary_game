extends Node2D

var pressed_buttons = []


func _input(event):
	if event.is_action_pressed("pausa"):
		$PauseMenuPanel.show()
		get_tree().paused = true


func pause_button_pressed(id):
	if not pressed_buttons.has(id):
		pressed_buttons.append(id)
	if pressed_buttons.size() == 2:
		pressed_buttons.clear()
		$PauseMenuPanel.show()
		get_tree().paused = true


func pause_button_released(id):
	if pressed_buttons.has(id):
		pressed_buttons.erase(id)


func resume():
	get_tree().paused = false
	$PauseMenuPanel.hide()


func back_to_titlescreen():
	Global.restart_game()
	hide_vuoidavvero()
	resume()


func show_vuoidavvero():
	$PauseMenuPanel/VuoiDavvero.show()
	$PauseMenuPanel/MainPauseMenu.hide()


func hide_vuoidavvero():
	$PauseMenuPanel/VuoiDavvero.hide()
	$PauseMenuPanel/MainPauseMenu.show()






