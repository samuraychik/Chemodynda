class_name Inventory
extends Node


signal negative_item_count

var items: Dictionary
var money: Money
var char_name: String


func _init():
	# new empty inventory
	items = {}
	money = Money.new(0, 0, 0)
	char_name = "eblanchik"


func add_item(item: Item, count: int):
	for key in items.keys():
		if items_equal(item, key):
			items[key] += count
			save_character()
			return
	items[item] = count
	save_character()


func remove_item(item: Item, count: int):
	var new_count = items[item] - count
	if new_count < 0:
		negative_item_count.emit()
	elif new_count == 0:
		items.erase(item)
		save_character()
	else:
		items[item] = new_count
		save_character()


func items_equal(item1: Item, item2: Item):
	return item1.item_name == item2.item_name \
	and item1.description == item2.description \
	and item1.category == item2.category \
	and item1.cost.golden == item2.cost.golden \
	and item1.cost.silver == item2.cost.silver \
	and item1.cost.copper == item2.cost.copper \
	and item1.weight == item2.weight \
	and item1.is_magical == item2.is_magical


func get_item_count(item: Item) -> int:
	return items[item]


func get_money() -> Money:
	return Money.new(money.golden, money.silver, money.copper)


func set_money(new_money: Money):
	money = Money.new(new_money.golden, new_money.silver, new_money.copper)
	save_character() 
	
	
func get_char_name() -> String:
	return char_name


func set_char_name(new_char_name: String):
	char_name = new_char_name


func get_total_weight() -> float:
	var total = 0
	for item in items.keys():
		total += item.weight * items[item]
	return total


func save_character():
	var save = {}
	if FileAccess.file_exists("res://database/save_test.json"):
		var save_string = FileAccess.open("res://database/save_test.json",FileAccess.READ)
		save = JSON.parse_string(save_string.get_as_text())
	else:
		save = {}
	for char in save:
		if char == char_name:
			parse_items(save)
			save[char]["money"] = parse_money()
	var new_save_string = FileAccess.open("res://database/save_test.json",FileAccess.WRITE)
	var json_string = JSON.stringify(save, " ", 4)
	new_save_string.store_string(json_string)


func parse_items(save):
	var res_item = ""
	var res_count = ""
	for item in items:
		res_item += str(item.id) + ", "
		res_count += str(get_item_count(item)) + ", "
	save[char_name]["items"] = res_item
	save[char_name]["count"] = res_count
	
		
func parse_money():
	return str(get_money().golden) + " " + str(get_money().silver) + " " + str(get_money().copper)
