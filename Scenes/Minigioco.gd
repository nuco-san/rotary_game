extends Node2D

export(int) var minigame_number

var time_left
var score := 0
var is_doing_fire_sequence = false


func _ready():
	time_left = Global.minigame_duration
	Global.connect("track_filled", self, "_on_track_filled")
	$ResultsUI.connect("results_read", self, "_on_results_read")


func start_minigame():
	$UI/MinigameCountdown.start_countdown()


func _on_track_filled(correctly):
	if correctly:
		score += 1
	else:
		score -= 1
		if minigame_number == 3 and is_doing_fire_sequence:
			stop_fire_sequence()
	if score == 8:
		if minigame_number == 3:
			start_fire_sequence()
		else:
			reset_minigame()


func _on_countdown_finished():
	$LevelTimer.start()
	$TrackManagerLeft.first_spawn()
	$TrackManagerBottom.first_spawn()
	$TrackManagerRight.first_spawn()
	$TrackManagerTop.first_spawn()


func _on_LevelTimer_timeout():
	time_left -= 1
	Global.emit_signal("timer_updated", time_left)
	if time_left <= 0:
		stop_minigame()
		$LevelTimer.stop()
		$ResultsUI.show()


func reset_minigame():
	stop_minigame()
	$UI/MinigameCountdown.show()
	$UI/MinigameCountdown.start_countdown()


func _on_results_read():
	$OutroSlides.show()


func load_next_minigame():
	Global.next_minigame()


func stop_minigame():
	yield(get_tree().create_timer(0.2), "timeout")
	Global.increase_round()
	score = 0
	$TrackManagerLeft.reset_tracks()
	$TrackManagerBottom.reset_tracks()
	$TrackManagerRight.reset_tracks()
	$TrackManagerTop.reset_tracks()


func start_fire_sequence():
	is_doing_fire_sequence = true
	$Sfondo_sotto/Fuoco.show()
	$FireTimer.start()
	yield($FireTimer, "timeout")
	reset_minigame()
	$Sfondo_sotto/Fuoco.hide()
	is_doing_fire_sequence = false


func stop_fire_sequence():
	is_doing_fire_sequence = false
	$Sfondo_sotto/Fuoco.show()
	$FireTimer.stop()
	$TrackManagerLeft.reset_tracks_fire()
	$TrackManagerBottom.reset_tracks_fire()
	$TrackManagerRight.reset_tracks_fire()
	$TrackManagerTop.reset_tracks_fire()
	






