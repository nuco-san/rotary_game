extends Node2D

signal track_empty

@export var track_id : int
@export var moving_food : PackedScene
@export var finishing_point : Marker2D

@export var food_res : FoodRes
@export var acceptable_id : String

@export var sprite_rotation : float = 0.0

var time_since_last_click : float = 0.0
var number_of_clicks : int = 0


func _ready():
	$FinishingPoint/FoodIcon.texture = load("res://03_Icone_EXPORT_ROTARY/" + acceptable_id + "_icona.png")
	$FinishingPoint/FoodIcon.rotation_degrees = sprite_rotation
	$FinishingPoint/ArrivedFoodSprite.rotation_degrees = sprite_rotation


func spawn_food():
	var new_food = moving_food.instantiate()
	add_child(new_food)
	randomize()
	var random_id = food_res.food_ids[randi() % food_res.food_ids.size()]
	new_food.set_id(random_id)
	new_food.set_sprite_rotation(sprite_rotation)
	new_food.food_clicked.connect(_on_food_avoided)
	new_food.move(finishing_point)


func _on_destination_area_entered(area):
	track_empty.emit(track_id)
	if acceptable_id == area.food_id:
		print(area.food_id)
		$FinishingPoint/FoodBackground.texture = load("res://04_Sprite_EXPORT_ROTARY/Slot_corretto.png")
	else:
		$FinishingPoint/FoodBackground.texture = load("res://04_Sprite_EXPORT_ROTARY/Slot_sbagliato.png")
	$FinishingPoint/ArrivedFoodSprite.texture = load("res://04_Sprite_EXPORT_ROTARY/Sprite_prodotti_senzaombra_EXPORT_ROTARY/" + area.food_id + "_sprite.png")
	area.destroy()


func _on_food_avoided():
	track_empty.emit(track_id)


func _on_clear_button_pressed():
	number_of_clicks += 1
	if number_of_clicks >= 5:
		$FinishingPoint/ArrivedFoodSprite.texture = null
		$FinishingPoint/FoodBackground.texture = null
		reset_clicks()
	$ClearButtonTimer.start()


func reset_clicks():
	number_of_clicks = 0
