extends Node2D

signal track_empty

export(int) var track_id
export(PackedScene) var moving_food
export(NodePath) var finishing_point_path
onready var finishing_point : Position2D = get_node(finishing_point_path)

export(Resource) var food_res
export(String) var acceptable_id
var acceptable_id_original
export(String) var acceptable_id_alt

export(float) var sprite_rotation = 0.0

var time_since_last_click : float = 0.0
var number_of_clicks : int = 0

var is_filled_correctly = false
var new_food_array = []



func _ready():
	acceptable_id_original = acceptable_id
	init_icon()
	$FinishingPoint/FoodIcon.rotation_degrees = sprite_rotation
	$FinishingPoint/ArrivedFoodSprite.rotation_degrees = sprite_rotation
	for food in food_res.food_ids:
		if food != acceptable_id:
			new_food_array.append(food)


func init_icon():
	$FinishingPoint/FoodIcon.texture = load("res://03_Icone_EXPORT_ROTARY/" + acceptable_id + "_icona.png")


func spawn_food():
	var new_food = moving_food.instance()
	$FoodContainer.add_child(new_food)
	randomize()
	var random_value = rand_range(0.0, 1.0)
	var random_id
	if is_filled_correctly == false:
		if random_value <= 0.2:
			random_id = acceptable_id
		else:
			random_id = food_res.food_ids[randi() % food_res.food_ids.size()]
	else:
		random_id = new_food_array[randi() % new_food_array.size()]
	new_food.set_id(random_id)
	new_food.set_sprite_rotation(sprite_rotation)
	new_food.connect( "food_clicked", self, "_on_food_avoided")
	new_food.move(finishing_point)


func _on_destination_area_entered(area):
	if acceptable_id == area.food_id:
		if is_filled_correctly and Global.current_minigame == 3:
			Global.emit_signal("too_much_food")
		if not is_filled_correctly:
			$CorrectSound.play()
			$FinishingPoint/FoodBackgroundCorrect.show()
			$FinishingPoint/FoodBackgroundWrong.hide()
			is_filled_correctly = true
			Global.emit_signal("track_filled", true)
			Global.emit_signal("tick_item", acceptable_id)
	else:
		$WrongSound.play()
		$FinishingPoint/FoodBackgroundCorrect.hide()
		$FinishingPoint/FoodBackgroundWrong.show()
		if is_filled_correctly:
			is_filled_correctly = false
			Global.emit_signal("track_filled", false)
			Global.emit_signal("untick_item", acceptable_id)
	$FinishingPoint/ArrivedFoodSprite.texture = load("res://04_Sprite_EXPORT_ROTARY/Sprite_prodotti_senzaombra_EXPORT_ROTARY/" + area.food_id + "_sprite.png")
	emit_signal("track_empty", track_id)
	area.destroy_arrive()


func _on_food_avoided():
	emit_signal("track_empty", track_id)


func _on_clear_button_pressed():
	$ScaleAnimation.play("tap")
	$TapSound.play()
	number_of_clicks += 1
	if number_of_clicks >= 5:
		reset_clicks()
		if is_filled_correctly:
			is_filled_correctly = false
			Global.emit_signal("track_filled", false)
		$CrashSound.play()
		$TransparencyAnimation.play("disappear")
		yield($TransparencyAnimation, "animation_finished")
		$FinishingPoint/ArrivedFoodSprite.modulate = Color.white
		$FinishingPoint/ArrivedFoodSprite.texture = null
		$FinishingPoint/FoodBackgroundCorrect.hide()
		$FinishingPoint/FoodBackgroundWrong.hide()
	$ClearButtonTimer.start()


func reset_clicks():
	number_of_clicks = 0


func reset_track():
	is_filled_correctly = false
	number_of_clicks = 0
	$ClearButtonTimer.stop()
	for food in $FoodContainer.get_children():
		food.queue_free()
	$FinishingPoint/FoodBackgroundCorrect.hide()
	$FinishingPoint/FoodBackgroundWrong.hide()
	$FinishingPoint/ArrivedFoodSprite.texture = null




