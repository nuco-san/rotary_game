extends Area2D


var food_id : String


func move(finishing_point : Marker2D):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", finishing_point.position, 2)


func destroy():
	queue_free()
