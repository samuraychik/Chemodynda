extends Control


@onready var child_basement = $ScrollContainerForDatabaseItems/DatabaseItemsContainer
var item_card_scene = preload("res://interface/scenes/DatabaseItemCard.tscn")
var list = []
var files = ["armor.json", "equip.json", "magic.json", "poison.json", "weapon.json"]
var use_filter: bool
var filter: Item.ItemCategory

func _on_return_button_pressed():
	visible = false
	
	
func _on_add_item_button_pressed():
	visible = true


func _close_available_items_menu():
	visible = false


func on_search(text):
	if len(text) >= 3:
		list = []
		for file in files:
			search_in_file(text, file)
		_update_items()


func _update_items():
	for old_item in child_basement.get_children():
		child_basement.remove_child(old_item)

	for new_item in list:
		if use_filter and new_item.category != filter:
			continue
		var item_card = item_card_scene.instantiate()
		item_card.set_item(new_item)
		child_basement.add_child(item_card)


func search_in_file(subtext, file):
	var items : Dictionary
	if FileAccess.file_exists("res://database/%s" % file):
		var save_string = FileAccess.open("res://database/%s" % file,FileAccess.READ)
		items = JSON.parse_string(save_string.get_as_text())
	else:
		items = {}
	for item in items:
		if subtext.to_lower() in item.to_lower():
			var new_item = Dab.item_by_id(items[item]["id"])
			list.append(new_item)


func _on_category_chosen(category_name: String):
	match category_name:
		"Оружие":
			use_filter = true
			filter = Item.ItemCategory.WEAPON
		"Защита":
			use_filter = true
			filter = Item.ItemCategory.ARMOR
		"Инструменты":
			use_filter = true
			filter = Item.ItemCategory.TOOL
		"Яды":
			use_filter = true
			filter = Item.ItemCategory.POISON
		"Магические":
			use_filter = true
			filter = Item.ItemCategory.MAGICAL
		"Другое":
			use_filter = true
			filter = Item.ItemCategory.OTHER
		"Все":
			use_filter = false

	_update_items()
