extends PanelContainer

signal countdown_finished

var countdown_time := 3

func _ready():
	show()

func start_countdown():
	$AudioStreamPlayer.play()
	$VBoxContainer/RoundLabel.text = "Round " + str(Global.current_round)
	countdown_time = 3
	$Timer.start()


func _on_Timer_timeout():
	countdown_time -= 1
	$VBoxContainer/CounterLabel.text = str(countdown_time)
	if countdown_time == 0:
		hide()
		$VBoxContainer/CounterLabel.text = str(3)
		$Timer.stop()
		emit_signal("countdown_finished")
	else:
		$AudioStreamPlayer.play()
