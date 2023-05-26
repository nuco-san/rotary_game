extends Control


func _ready():
	$Punteggio.text = str(Global.total_score)
	$Acqua/AcquaValue.text = str(Global.total_score * 480)
	$Acqua/VascheValue.text = "= " + str(Global.total_score * 4) + " vasche da bagno"
	$Terra/TerraValue.text = str(Global.total_score * 830)
	$Terra/CampiValue.text = "= " + str(Global.total_score * 2) + " campi da basket"


func next_scene():
	get_tree().change_scene("res://Scenes/FinalScreen.tscn")
