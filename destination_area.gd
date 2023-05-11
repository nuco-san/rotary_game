extends Area2D


@export var acceptable_ids := []


func _on_area_entered(area):
	if acceptable_ids.has(area.food_id):
		print("ok")
		area.destroy()
