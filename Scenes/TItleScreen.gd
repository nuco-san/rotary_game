extends Control


func _ready():
	if OS.window_fullscreen:
		$TitleScreenUI/MainButtons/FullscreenButton.text = "SCHERMO INTERO: SÌ"
	else:
		$TitleScreenUI/MainButtons/FullscreenButton.text = "SCHERMO INTERO: NO"


func start_story_mode():
	get_tree().change_scene("res://Scenes/InitialScreen.tscn")
	Global.current_game_mode = Global.game_modes.STORY


func start_selected_minigame(number):
	Global.load_minigame(number)
	Global.current_game_mode = Global.game_modes.SELECTION


func show_titlescreen():
	$TitleScreenUI.show()
	$SelezioneUI.hide()
	$CreditsUI.hide()


func show_level_selection():
	$TitleScreenUI.hide()
	$SelezioneUI.show()


func show_credits():
	$TitleScreenUI.hide()
	$CreditsUI.show()


func toggle_fullscreen():
	if OS.window_fullscreen:
		OS.window_fullscreen = false
		$TitleScreenUI/MainButtons/FullscreenButton.text = "SCHERMO INTERO: NO"
		Global.emit_signal("fullscreen_off")
		return
	if not OS.window_fullscreen:
		OS.window_fullscreen = true
		$TitleScreenUI/MainButtons/FullscreenButton.text = "SCHERMO INTERO: SÌ"
		Global.emit_signal("fullscreen_on")
		return




