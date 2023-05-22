extends Control

signal results_read

export(PackedScene) var posto_sopra
export(PackedScene) var posto_sotto
export(PackedScene) var tovaglia_slice

var acqua_value
var vasche_value
var terra_value
var basket_value


func init_animations():
	spawn_posti()
	calculate_numbers()
	$Totalizzatore_UI/Punteggio.text = str(Global.total_score)
	$Totalizzatore_UI/PunteggioAggiuntivo.text = "+" + str(Global.partial_score)
	$StartTimer.start()


func calculate_numbers():
	acqua_value = Global.total_score * 480
	vasche_value = Global.total_score * 4
	terra_value = Global.total_score * 830
	basket_value = Global.total_score * 2


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
	$SoundAnimator.play("sound_up")
	$EatingSound.play()
	var score_to_use = Global.total_score
	$NumbersTimer.wait_time = 3.0 / Global.partial_score
	for n in Global.partial_score:
		score_to_use += 1
		acqua_value += 480
		vasche_value += 4
		terra_value += 830
		basket_value += 2
		$Ding.play()
		$Totalizzatore_UI/Punteggio.text = str(score_to_use)
		$Totalizzatore_UI/Acqua/AcquaValue.text = str(acqua_value) + "l"
		$Totalizzatore_UI/Acqua/VascheValue.text = "= " + str(vasche_value) + " vasche da bagno"
		$Totalizzatore_UI/Terra/TerraValue.text = str(terra_value) + "m²"
		$Totalizzatore_UI/Terra/CampiValue.text =  "= " + str(basket_value) + " campi da basket"
		$NumbersTimer.start()
		yield($NumbersTimer, "timeout")
	$Totalizzatore_UI/PunteggioAggiuntivo.hide()
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







