extends Node2D

@export var moving_food : PackedScene
@export var finishing_point : Marker2D
@export var possible_food_ids := []


func _ready():
	spawn_food()


func spawn_food():
	var new_food = moving_food.instantiate()
	add_child(new_food)
	randomize()
	var random_id = possible_food_ids[randi() % possible_food_ids.size()]
	new_food.food_id = random_id
	new_food.move(finishing_point)
