extends Sprite

signal slides_finished

export(Array) var slides = []

var current_slide_number = 0
var total_slides_number


func _ready():
	total_slides_number = slides.size()
	texture = slides[0]


func next_slide():
	current_slide_number += 1
	if current_slide_number == total_slides_number:
		emit_signal("slides_finished")
		hide()
	else:
		texture = slides[current_slide_number]
