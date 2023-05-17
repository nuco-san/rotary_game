extends Node2D

export(NodePath) var track_1_path
export(NodePath) var track_2_path
onready var track_1 = get_node(track_1_path)
onready var track_2 = get_node(track_2_path)

export(Vector2) var spawn_time_interval

var track_1_empty = false
var track_2_empty = false

var is_spawning = false


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


