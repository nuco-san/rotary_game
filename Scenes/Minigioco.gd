extends Node2D

export(int) var minigame_number

var time_left
var correct_foods := 0
var correct_foods_goal := 8
var fire_time_left = 5

var is_winning_round = false
var is_stopping_minigame = false
var is_stopping_fire_sequence = false
var is_doing_fire_sequence = false



func _ready():
	time_left = Global.minigame_duration
	Global.connect("track_filled", self, "_on_track_filled")


func start_minigame():
	$UI/MinigameCountdown.show()


func _on_track_filled(correctly):
	if correctly:
		correct_foods += 1
		if correct_foods == correct_foods_goal - 1:
			increase_right_spawn_probability()
	else:
		correct_foods -= 1
		if minigame_number == 3 and is_doing_fire_sequence:
			stop_fire_sequence()
	if correct_foods == correct_foods_goal and is_stopping_minigame == false and is_stopping_fire_sequence == false:
		if minigame_number == 3:
			start_fire_sequence()
		else:
			reset_minigame()


func _on_too_much_food():
	if minigame_number == 3 and correct_foods == correct_foods_goal:
		stop_fire_sequence()


func _on_countdown_finished():
	$UI/FoodList.untick_all_items()
	$LevelTimer.paused = false
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
		$UI/MinigameCountdown.stop_countdown()
		$UI/TimeOut.show()
		$UI/TimeOut/TimeOutTimer.start()
		yield($UI/TimeOut/TimeOutTimer, "timeout")
		$UI/TimeOut.hide()
		$Totalizzatore.show()
		$Totalizzatore.init_animations()


func reset_minigame():
	Global.increase_round()
	Global.emit_signal("round_updated")
	stop_minigame()
	$UI/MinigameCountdown.show()
	$UI/MinigameCountdown.show_yeah()
	$RoundCompletedSound.play()
	if minigame_number == 3:
		$TrackManagerLeft.change_recipe()
		$TrackManagerBottom.change_recipe()
		$TrackManagerRight.change_recipe()
		$TrackManagerTop.change_recipe()
		if Global.current_round % 2 == 1:
			$UI/FoodList.title = "Gnocchi alla sorrentina"
			$UI/FoodList.foods_res = load("res://sorrentina_foods.tres")
			$UI/FoodList.clear_list()
			$UI/FoodList.init_list()
		if Global.current_round % 2 == 0:
			$UI/FoodList.title = "Frittata colorata"
			$UI/FoodList.foods_res = load("res://frittata_foods.tres")
			$UI/FoodList.clear_list()
			$UI/FoodList.init_list()


func _on_results_read():
	$OutroSlides.show()


func _on_outro_slides_read():
	Global.next_minigame()


func stop_minigame():
	is_stopping_minigame = true
	yield(get_tree().create_timer(0.05), "timeout")
	correct_foods = 0
	$LevelTimer.paused = true
	$TrackManagerLeft.reset_tracks()
	$TrackManagerBottom.reset_tracks()
	$TrackManagerRight.reset_tracks()
	$TrackManagerTop.reset_tracks()
	is_stopping_minigame = false


func start_fire_sequence():
	is_doing_fire_sequence = true
	$Sfondo_sotto/Fuoco/FireSound.play()
	$Sfondo_sotto/Fuoco.show()
	$FireTimer.start()
	$UI/FireTimerLabel.show()


func _on_FireTimer_timeout():
	fire_time_left -= 1
	$UI/FireTimerLabel.text = str(fire_time_left)
	if fire_time_left <= 0:
		complete_fire_sequence()


func complete_fire_sequence():
	fire_time_left = 5
	reset_minigame()
	$Sfondo_sotto/Fuoco.hide()
	$UI/FireTimerLabel.hide()
	is_doing_fire_sequence = false
	$Sfondo_sotto/Fuoco/FireSound.stop()
	$FireTimer.stop()
	correct_foods = 0


func stop_fire_sequence():
	is_stopping_fire_sequence = true
	yield(get_tree().create_timer(0.05), "timeout")
	$UI/FoodList.untick_all_items()
	fire_time_left = 5
	$UI/FireTimerLabel.text = str(fire_time_left)
	$Sfondo_sotto/Fuoco/FireSound.stop()
	is_doing_fire_sequence = false
	$Sfondo_sotto/Fuoco.hide()
	$FireTimer.stop()
	$TrackManagerLeft.reset_tracks_fire()
	$TrackManagerBottom.reset_tracks_fire()
	$TrackManagerRight.reset_tracks_fire()
	$TrackManagerTop.reset_tracks_fire()
	correct_foods = 0
	is_stopping_fire_sequence = false


func increase_right_spawn_probability():
	$TrackManagerLeft.increase_spawn_probability()
	$TrackManagerBottom.increase_spawn_probability()
	$TrackManagerRight.increase_spawn_probability()
	$TrackManagerTop.increase_spawn_probability()

