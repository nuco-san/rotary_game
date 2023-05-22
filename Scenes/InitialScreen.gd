extends Control


func show_second_slide():
	$Tavola/Slide2.show()
	$Tavola/Slide1.hide()


func load_first_minigame():
	Global.load_minigame(1)
