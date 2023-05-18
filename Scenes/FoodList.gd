extends VBoxContainer

export(PackedScene) var ListItem
export(Resource) var foods_res
export(String) var title


func _ready():
	Global.connect("tick_item", self, "tick_item")
	Global.connect("untick_item", self, "untick_item")
	init_list()

func tick_item(food_name):
	for item in $VBoxContainer.get_children():
		if item.item_name == food_name:
			item.tick()


func untick_item(food_name):
	for item in $VBoxContainer.get_children():
		if item.item_name == food_name:
			item.untick()


func clear_list():
	for item in $VBoxContainer.get_children():
		item.queue_free()


func init_list():
	$Title.text = title
	for food in foods_res.food_ids:
		var new_list_item = ListItem.instance()
		new_list_item.item_name = food
		$VBoxContainer.add_child(new_list_item)
