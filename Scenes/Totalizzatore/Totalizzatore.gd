extends Control

signal results_read

export(PackedScene) var posto_sopra
export(PackedScene) var posto_sotto
export(PackedScene) var tovaglia_slice


func init_animations():
	spawn_posti()
	$Totalizzatore_UI/Punteggio.text = str(Global.total_score)
	$StartTimer.start()
	$SoundAnimator.play("sound_up")
	$EatingSound.play()


func spawn_posti():
	if Global.partial_score > 0:
		for n in Global.partial_score:
			if n % 2 == 0:
				var posto_new = posto_sotto.instance()
				posto_new.randomize_textures()
				$Tavola/PostiTavolaSotto.add_child(posto_new)
			if n % 2 == 1:
				var posto_new = posto_sopra.instance()
				posto_new.randomize_textures()
				$Tavola/PostiTavolaSopra.add_child(posto_new)
		for n in Global.partial_score * 2:
			var new_slice = tovaglia_slice.instance()
			$Tavola/TovagliaContainer.add_child(new_slice)
	else:
		for n in 4:
			var new_slice = tovaglia_slice.instance()
			$Tavola/TovagliaContainer.add_child(new_slice)


func numbers_animation():
	var score_to_use = Global.total_score
	$NumbersTimer.wait_time = 3.0 / Global.partial_score
	for n in Global.partial_score:
		score_to_use += 1
		$Ding.play()
		$Totalizzatore_UI/Punteggio.text = str(score_to_use)
		$NumbersTimer.start()
		yield($NumbersTimer, "timeout")
	table_animation()


func table_animation():
	if Global.partial_score > 2:
		var medium_length = ($Tavola/PostiTavolaSotto.rect_size.x + $Tavola/PostiTavolaSopra.rect_size.x) / 2
		var destination_pos_x = $Tavola.rect_position.x - medium_length + 800
		$Tween.interpolate_property($Tavola, "rect_position:x", $Tavola.rect_position.x, destination_pos_x, Global.partial_score/3, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
	Global.update_total_score()
	$Totalizzatore_UI/ContinuaButton.show()


func _on_StartTimer_timeout():
	if Global.partial_score > 0:
		numbers_animation()
	else:
		$ScoreZero.show()
		$Totalizzatore_UI/ContinuaButton.show()


func end_totalizzatore():
	emit_signal("results_read")










