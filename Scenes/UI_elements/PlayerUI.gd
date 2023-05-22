extends Control

export(int) var player_id

func _ready():
	update_timer(Global.minigame_duration)
	Global.connect("timer_updated", self, "update_timer")
	Global.connect("round_updated", self, "update_round")
	$PlayerLabel.text = "Player " + str(player_id)	


func update_timer(time):
	var minutes = floor(time / 60)
	var seconds = time - minutes * 60
	$TimerLabel.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)


func update_round():
	$RoundContainer/RoundValue.text = str(Global.current_round)
