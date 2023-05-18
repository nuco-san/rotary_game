extends Control


func start_story_mode():
	Global.load_minigame(1)
	Global.current_game_mode = Global.game_modes.STORY

func show_level_selection():
	$MainButtons.hide()
	$LevelSelectionButtons.show()

func start_selected_minigame(number):
	Global.load_minigame(number)
	Global.current_game_mode = Global.game_modes.SELECTION


func hide_level_selection():
	$MainButtons.show()
	$LevelSelectionButtons.hide()
