extends Button


signal button_pressed


func btn_pressed():
	$AudioStreamPlayer.play()
	emit_signal("button_pressed")
