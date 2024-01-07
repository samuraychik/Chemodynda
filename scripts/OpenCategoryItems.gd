extends Node


# Called when the node enters the scene tree for the first time.
func _ready():	
	pass # Replace with function body.

func _on_toggled(toggled_on: bool, count_items: int):
	var item_table = get_parent().get_parent().get_parent()
	var children = item_table.get_children()
	if len(children) > 1:
		for i in range(len(children)):
			if i == 0:
				continue
			children[i].queue_free()
		print(children)
		
	if toggled_on:
		var category_items: PackedScene = load("res://scenes/prefabs_scenes/CategoryItems.tscn")
		var category_items_instance = category_items.instantiate()
		category_items_instance.position = Vector2(0, 60)
		var items_container = category_items_instance.get_child(1).get_child(0)

		for i in range(count_items):
			var item: PackedScene = load("res://scenes/prefabs_scenes/Item.tscn")
			var item_instance = item.instantiate()
			item_instance.custom_minimum_size = Vector2(740, 120)
			item_instance.get_child(item_instance.get_child_count() - 1).text = "%s" % i
			items_container.add_child(item_instance)
		get_parent().get_parent().get_parent().add_child(category_items_instance)
	
