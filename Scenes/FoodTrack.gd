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

var is_filled = false
var is_filled_correctly = false
var new_food_array = []

var is_clearing_area = false

export(float) var correct_spawn_probability_min = 0.2
export(float) var correct_spawn_probability_max = 0.4
export(float) var correct_spawn_probabilty



func _ready():
	correct_spawn_probabilty = correct_spawn_probability_min
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
		if random_value <= correct_spawn_probabilty:
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
	if is_clearing_area == false:
		if is_filled == false or is_filled_correctly == true:
			if acceptable_id == area.food_id:
				if is_filled_correctly and Global.current_minigame == 3:
					Global.emit_signal("too_much_food")
				else:
					is_filled = true
					is_filled_correctly = true
					$CorrectSound.play()
					$FinishingPoint/FoodBackgroundCorrect.show()
					$FinishingPoint/FoodBackgroundWrong.hide()
					$FinishingPoint/ArrivedFoodSprite.texture = load("res://04_Sprite_EXPORT_ROTARY/Sprite_prodotti_senzaombra_EXPORT_ROTARY/" + area.food_id + "_sprite.png")
					Global.emit_signal("track_filled", true)
					Global.emit_signal("tick_item", acceptable_id)
			if acceptable_id != area.food_id:
				is_filled = true
				$WrongSound.play()
				$FinishingPoint/FoodBackgroundCorrect.hide()
				$FinishingPoint/FoodBackgroundWrong.show()
				$FinishingPoint/ArrivedFoodSprite.texture = load("res://04_Sprite_EXPORT_ROTARY/Sprite_prodotti_senzaombra_EXPORT_ROTARY/" + area.food_id + "_sprite.png")
				if is_filled_correctly:
					is_filled_correctly = false
					Global.emit_signal("track_filled", false)
					Global.emit_signal("untick_item", acceptable_id)
	emit_signal("track_empty", track_id)
	area.destroy_arrive()


func _on_food_avoided():
	emit_signal("track_empty", track_id)


func _on_clear_button_pressed():
	if is_filled:
		is_clearing_area = true
		$ScaleAnimation.play("tap")
		$TapSound.play()
		number_of_clicks += 1
		if number_of_clicks >= 5:
			reset_clicks()
			is_filled = false
			if is_filled_correctly:
				is_filled_correctly = false
				Global.emit_signal("track_filled", false)
				Global.emit_signal("untick_item", acceptable_id)
			$CrashSound.play()
			$FinishingPoint/ArrivedFoodSprite.modulate = Color.white
			$FinishingPoint/ArrivedFoodSprite.texture = null
			$FinishingPoint/FoodBackgroundCorrect.hide()
			$FinishingPoint/FoodBackgroundWrong.hide()
			yield(get_tree().create_timer(0.1), "timeout")
			is_clearing_area = false
		$ClearButtonTimer.start()


func reset_clicks():
	number_of_clicks = 0
	is_clearing_area = false


func reset_track():
	is_filled = false
	is_filled_correctly = false
	number_of_clicks = 0
	correct_spawn_probabilty = correct_spawn_probability_min
	$ClearButtonTimer.stop()
	for food in $FoodContainer.get_children():
		food.queue_free()
	$FinishingPoint/FoodBackgroundCorrect.hide()
	$FinishingPoint/FoodBackgroundWrong.hide()
	$FinishingPoint/ArrivedFoodSprite.texture = null


func increase_right_spawn_probabilty():
	if not is_filled_correctly:
		correct_spawn_probabilty = correct_spawn_probability_max

