extends Button


signal button_pressed

func _ready():
	$AnimationPlayer.play("button_highlight")


func btn_pressed():
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, "finished")
	emit_signal("button_pressed")
