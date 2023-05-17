extends Control


export(String) var item_name

func _ready():
	$ListaLabel.text = item_name


func tick():
	$Barra.show()

func untick():
	$Barra.hide()
