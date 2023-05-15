extends Control

export(int) var player_id

func _ready():
	Global.connect("timer_updated", self, "update_timer")
	Global.connect("round_updated", self, "update_round")
	$PlayerLabel.text = "Player " + str(player_id)
	


func update_timer(time):
	var minutes = floor(time / 60)
	var seconds = time - minutes * 60
	$TimerLabel.text = str(minutes) + ":" + str(seconds)


func update_round(_round):
	$RoundContainer/RoundValue.text = "0" + str(_round)
