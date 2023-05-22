extends Control


func start_story_mode():
	Global.load_minigame(1)
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



