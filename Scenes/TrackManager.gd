extends Node2D

export(NodePath) var track_1_path
export(NodePath) var track_2_path
onready var track_1 = get_node(track_1_path)
onready var track_2 = get_node(track_2_path)

export(Vector2) var spawn_time_interval

var track_1_empty = false
var track_2_empty = false

var is_spawning = false

export(Resource) var minigame3_recipe_1
export(Resource) var minigame3_recipe_2


func _ready():
	track_1.connect("track_empty", self, "_on_track_empty")
	track_2.connect("track_empty", self, "_on_track_empty")


func first_spawn():
	randomize_timer()
	$Timer.start()
	track_1.spawn_food()


func _on_track_empty(id):
	if not is_spawning:
		is_spawning = true
		randomize_timer()
		$Timer.start()
		yield($Timer, "timeout")
		if id == 1:
			track_2.spawn_food()
		if id == 2:
			track_1.spawn_food()
		is_spawning = false


func reset_tracks():
	$Timer.paused = true
	$FoodTrack_1.reset_track()
	$FoodTrack_2.reset_track()


func randomize_timer():
	randomize()
	$Timer.wait_time = rand_range(spawn_time_interval.x, spawn_time_interval.y)


func reset_tracks_fire():
	$Timer.paused = true
	$FoodTrack_1.reset_track()
	$FoodTrack_2.reset_track()
	yield(get_tree().create_timer(1.0), "timeout")
	first_spawn()
	$Timer.paused = false


func change_recipe():
	if Global.current_round % 2 == 0:
		$FoodTrack_1.food_res = minigame3_recipe_1
		$FoodTrack_1.acceptable_id = $FoodTrack_1.acceptable_id_original
		$FoodTrack_1.init_icon()
		$FoodTrack_2.food_res = minigame3_recipe_1
		$FoodTrack_2.acceptable_id = $FoodTrack_2.acceptable_id_original
		$FoodTrack_2.init_icon()
	if Global.current_round % 2 == 1:
		$FoodTrack_1.food_res = minigame3_recipe_2
		$FoodTrack_1.acceptable_id = $FoodTrack_1.acceptable_id_alt
		$FoodTrack_1.init_icon()
		$FoodTrack_2.food_res = minigame3_recipe_2
		$FoodTrack_2.acceptable_id = $FoodTrack_2.acceptable_id_alt
		$FoodTrack_2.init_icon()




