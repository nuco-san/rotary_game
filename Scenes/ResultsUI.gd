extends Control

signal results_read


func show_results():
	$RoundsCounter.text = str(Global.current_round)


func close_results():
	emit_signal("results_read")
	hide()
