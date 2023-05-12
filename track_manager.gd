extends Node2D

@export var track_1 : Node2D
@export var track_2 : Node2D

@export var spawn_time_interval : Vector2

var track_1_empty = false
var track_2_empty = false




func _ready():
	track_1.track_empty.connect(_on_track_empty)
	track_2.track_empty.connect(_on_track_empty)
	first_spawn()

func first_spawn():
	track_1.spawn_food()


func _on_track_empty(id):
	print(id)
	randomize()
	$Timer.wait_time = randf_range(spawn_time_interval.x, spawn_time_interval.y)
	$Timer.start()
	await $Timer.timeout
	if id == 1:
		track_2.spawn_food()
	if id == 2:
		track_1.spawn_food()








