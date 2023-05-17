extends Control


func start_story_mode():
	Global.load_minigame(1)

func show_level_selection():
	$MainButtons.hide()
	$LevelSelectionButtons.show()

func start_selected_minigame(number):
	Global.load_minigame(number)
