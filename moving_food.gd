extends Area2D

signal food_clicked
var food_id : String
var movement_time : float = 1.5


func set_id(id):
	food_id = id
	$Sprite2D.texture = load("res://04_Sprite_EXPORT_ROTARY/Sprite_prodotti_senzaombra_EXPORT_ROTARY/" + id + "_sprite.png")


func move(finishing_point : Marker2D):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", finishing_point.position, movement_time)


func destroy():
	queue_free()


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		food_clicked.emit()
		destroy()
