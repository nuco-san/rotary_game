extends Node2D

signal track_empty

export(int) var track_id
export(PackedScene) var moving_food
export(NodePath) var finishing_point_path
onready var finishing_point : Position2D = get_node(finishing_point_path)

export(Resource) var food_res
export(String) var acceptable_id

export(float) var sprite_rotation = 0.0

var time_since_last_click : float = 0.0
var number_of_clicks : int = 0

var is_filled_correctly = false


func _ready():
	$FinishingPoint/FoodIcon.texture = load("res://03_Icone_EXPORT_ROTARY/" + acceptable_id + "_icona.png")
	$FinishingPoint/FoodIcon.rotation_degrees = sprite_rotation
	$FinishingPoint/ArrivedFoodSprite.rotation_degrees = sprite_rotation


func spawn_food():
	var new_food = moving_food.instance()
	add_child(new_food)
	randomize()
	var random_value = rand_range(0.0, 1.0)
	var random_id
	if is_filled_correctly == false:
		if random_value <= 0.2:
			random_id = acceptable_id
		else:
			random_id = food_res.food_ids[randi() % food_res.food_ids.size()]
	else:
		var new_food_array = food_res.food_ids
		new_food_array.erase(acceptable_id)
		random_id = new_food_array[randi() % new_food_array.size()]
	new_food.set_id(random_id)
	new_food.set_sprite_rotation(sprite_rotation)
	new_food.connect( "food_clicked", self, "_on_food_avoided")
	new_food.move(finishing_point)


func _on_destination_area_entered(area):
	emit_signal("track_empty", track_id)
	if acceptable_id == area.food_id:
		$FinishingPoint/FoodBackground.texture = load("res://04_Sprite_EXPORT_ROTARY/Slot_corretto.png")
		is_filled_correctly = true
		Global.emit_signal("track_filled", true)
	else:
		$FinishingPoint/FoodBackground.texture = load("res://04_Sprite_EXPORT_ROTARY/Slot_sbagliato.png")
		is_filled_correctly = false
		Global.emit_signal("track_filled", false)
	$FinishingPoint/ArrivedFoodSprite.texture = load("res://04_Sprite_EXPORT_ROTARY/Sprite_prodotti_senzaombra_EXPORT_ROTARY/" + area.food_id + "_sprite.png")
	area.destroy()


func _on_food_avoided():
	emit_signal("track_empty", track_id)


func _on_clear_button_pressed():
	number_of_clicks += 1
	if number_of_clicks >= 5:
		$FinishingPoint/ArrivedFoodSprite.texture = null
		$FinishingPoint/FoodBackground.texture = null
		reset_clicks()
	$ClearButtonTimer.start()


func reset_clicks():
	number_of_clicks = 0
