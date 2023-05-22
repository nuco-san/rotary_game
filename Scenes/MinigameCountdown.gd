extends Control

signal countdown_finished

var countdown_time := 3

func _ready():
	show()


func start_countdown():
	$VBoxContainer/CounterLabel.show()
	$IniziaButton.hide()
	$YeahLabel.hide()
	$VBoxContainer.show()
	$AudioStreamPlayer.play()
	$VBoxContainer/RoundLabel.text = "Round " + str(Global.current_round)
	countdown_time = 3
	$CountdownTimer.start()


func show_yeah():
	$VBoxContainer/RoundLabel.text = "Round " + str(Global.current_round)
	$YeahLabel.show()
	$VBoxContainer.hide()
	$YeahTimer.start()
	yield($YeahTimer, "timeout")
	$VBoxContainer/CounterLabel.hide()
	$YeahLabel.hide()
	$VBoxContainer.show()
	$IniziaButton.show()


func _on_Timer_timeout():
	countdown_time -= 1
	$VBoxContainer/CounterLabel.text = str(countdown_time)
	if countdown_time == 0:
		hide()
		$VBoxContainer/CounterLabel.text = str(3)
		$CountdownTimer.stop()
		emit_signal("countdown_finished")
	else:
		$AudioStreamPlayer.play()


func stop_countdown():
	$CountdownTimer.stop()
	hide()



