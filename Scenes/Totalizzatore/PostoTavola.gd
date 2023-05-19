extends Control

export(Array) var piatti = []
export(Array) var mani = []
export(Array) var companatici = []


func randomize_textures():
	randomize()
	$Piatto.texture = piatti[randi() % piatti.size()]
	$Mano.texture = mani[randi() % mani.size()]
	$Companatico.texture = companatici[randi() % companatici.size()]
