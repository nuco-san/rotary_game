extends PanelContainer

signal countdown_finished

var countdown_time := 3


func _ready():
	start_countdown()


func start_countdown():
	countdown_time = 3
	$Timer.start()


func _on_Timer_timeout():
	countdown_time -= 1
	$PlayerLabel.text = str(countdown_time)
	if countdown_time == 0:
		emit_signal("countdown_finished")
		hide()
