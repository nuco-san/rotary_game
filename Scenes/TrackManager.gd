extends Node2D

export(NodePath) var track_1_path
export(NodePath) var track_2_path
onready var track_1 = get_node(track_1_path)
onready var track_2 = get_node(track_2_path)

export(Vector2) var spawn_time_interval

var track_1_empty = false
var track_2_empty = false




func _ready():
	track_1.connect("track_empty", self, "_on_track_empty")
	track_2.connect("track_empty", self, "_on_track_empty")
	first_spawn()

func first_spawn():
	track_1.spawn_food()


func _on_track_empty(id):
	randomize()
	$Timer.wait_time = rand_range(spawn_time_interval.x, spawn_time_interval.y)
	$Timer.start()
	yield($Timer, "timeout")
	if id == 1:
		track_2.spawn_food()
	if id == 2:
		track_1.spawn_food()








