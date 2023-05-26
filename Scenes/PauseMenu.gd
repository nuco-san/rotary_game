extends Node2D

var pressed_buttons = []


func _ready():
	Global.connect("fullscreen_off", self, "fullscreen_button_no")
	Global.connect("fullscreen_on", self, "fullscreen_button_yes")


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


func toggle_fullscreen():
	if OS.window_fullscreen:
		OS.window_fullscreen = false
		fullscreen_button_no()
		return
	if not OS.window_fullscreen:
		OS.window_fullscreen = true
		fullscreen_button_yes()
		return


func fullscreen_button_no():
	$PauseMenuPanel/MainPauseMenu/FullscreenButton.text = "SCHERMO INTERO: NO"

func fullscreen_button_yes():
	$PauseMenuPanel/MainPauseMenu/FullscreenButton.text = "SCHERMO INTERO: SÌ"

