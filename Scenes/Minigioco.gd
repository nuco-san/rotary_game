extends Node2D


var time_left := 600
var score := 0


func _ready():
	Global.connect("track_filled", self, "_on_track_filled")


func _on_track_filled(correctly):
	if correctly:
		score += 1
	else:
		score -= 1
	if score == 8:
		reset_minigame()


func _on_countdown_finished():
	$TrackManagerLeft.first_spawn()
	$TrackManagerBottom.first_spawn()
	$TrackManagerRight.first_spawn()
	$TrackManagerTop.first_spawn()


func _on_LevelTimer_timeout():
	time_left -= 1
	emit_signal("timer_updated", time_left)
	if time_left <= 0:
		pass


func reset_minigame():
	yield(get_tree().create_timer(0.2), "timeout")
	Global.increase_round()
	score = 0
	$TrackManagerLeft.reset_tracks()
	$TrackManagerBottom.reset_tracks()
	$TrackManagerRight.reset_tracks()
	$TrackManagerTop.reset_tracks()
	$UI/MinigameCountdown.show()
	$UI/MinigameCountdown.start_countdown()

