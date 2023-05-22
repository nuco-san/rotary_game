extends Control


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



