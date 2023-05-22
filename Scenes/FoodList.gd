extends VBoxContainer

export(PackedScene) var ListItem
export(Resource) var foods_res
export(String) var title

var foods_dictionary = {}


func _ready():
	Global.connect("tick_item", self, "tick_item")
	Global.connect("untick_item", self, "untick_item")
	init_list()


func tick_item(food_name):
	if Global.current_minigame < 3:
		for item in $VBoxContainer.get_children():
			if item.item_name == food_name:
				item.tick()
	if Global.current_minigame == 3:
		var food_value = foods_dictionary[food_name]
		food_value += 1
		foods_dictionary[food_name] = food_value
		if foods_dictionary[food_name] == 2:
			for item in $VBoxContainer.get_children():
				if item.item_name == food_name:
					item.tick()


func untick_item(food_name):
	for item in $VBoxContainer.get_children():
		if item.item_name == food_name:
			item.untick()
	if Global.current_minigame == 3:
		var food_value = foods_dictionary[food_name]
		food_value -= 1
		foods_dictionary[food_name] = food_value
		if foods_dictionary[food_name] == 0:
			for item in $VBoxContainer.get_children():
				if item.item_name == food_name:
					item.untick()


func clear_list():
	for item in $VBoxContainer.get_children():
		item.queue_free()


func init_list():
	$Title.text = title
	init_dictionary()
	for food in foods_res.food_ids:
		var new_list_item = ListItem.instance()
		new_list_item.item_name = food
		$VBoxContainer.add_child(new_list_item)

func untick_all_items():
	for item in $VBoxContainer.get_children():
		item.untick()


func init_dictionary():
	foods_dictionary.clear()
	for food in foods_res.food_ids:
		foods_dictionary[food] = 0

