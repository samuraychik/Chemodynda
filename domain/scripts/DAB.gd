extends Node


# Called when the node enters the scene tree for the first time.
func item_by_id(id):
	var float_id = float(id)
	var new_item = find_item(str(float_id))
	var new_item_name = new_item[0]
	var new_item_chars = new_item[1]
	match str(float_id)[0]:
			"1":
				return Item.new(
					new_item_chars["id"],
					new_item_name,
					"",
					Item.ItemCategory.ARMOR,
					Item.ItemRarity.NONE,
					parse_money(new_item_chars["cost"]),
					float(new_item_chars["weight"].replace(" фнт.", "")))
			"2":
				return Item.new(
					new_item_chars["id"],
					new_item_name,
					"",
					Item.ItemCategory.WEAPON,
					Item.ItemRarity.NONE,
					parse_money(new_item_chars["cost"]),
					float(new_item_chars["weight"].replace(" фнт.", "")))
			"3":
				return Item.new(
					new_item_chars["id"],
					new_item_name,
					new_item_chars["description"],
					Item.ItemCategory.OTHER,
					Item.ItemRarity.NONE,
					parse_money(new_item_chars["cost"]),
					float(new_item_chars["weight"].replace(" фнт.", "")))
			"4":
				return Item.new(
					new_item_chars["id"],
					new_item_name,
					new_item_chars["description"],
					Item.ItemCategory.TOOL,
					Item.ItemRarity.NONE,
					parse_money(new_item_chars["cost"]),
					float(new_item_chars["weight"].replace(" фнт.", "")))
			"5":
				return Item.new(
					new_item_chars["id"],
					new_item_name,
					new_item_chars["description"],
					Item.ItemCategory.POISON,
					Item.ItemRarity.NONE,
					parse_money(new_item_chars["cost"]),
					float(new_item_chars["weight"].replace(" фнт.", "")))
			"6":
				return Item.new(
					new_item_chars["id"],
					new_item_name,
					new_item_chars["description"],
					Item.ItemCategory.MAGICAL,
					parse_rarity(new_item_chars["rarity"]),
					parse_money(new_item_chars["cost"]),
					float(new_item_chars["weight"].replace(" фнт.", "")))
	
	
func find_item(id):
	var choose_file = {
		"1": "armor.json",
		"2": "weapon.json",
		"3": "equip.json",
		#TODO обновить, когда дадут тулсы
		"5": "poison.json",
		"6": "magic.json"
	}
	var file = choose_file[id[0]]
	var items : Dictionary
	if FileAccess.file_exists("res://database/%s" % file):
		var save_string = FileAccess.open("res://database/%s" % file,FileAccess.READ)
		items = JSON.parse_string(save_string.get_as_text())
	else:
		items = {}
	for item in items:
		if items[item]["id"] == float(id):
			return [item, items[item]]
			
func parse_money(money_string):
	if "зм" in money_string:
		return(Money.new(int(money_string.replace("зм", "")), 0, 0))
	if "см" in money_string:
		return(Money.new(0, int(money_string.replace("см", "")), 0))
	if "мм" in money_string:
		return(Money.new(0, 0, int(money_string.replace("мм", ""))))
		
func parse_rarity(rarity_string):
	var choose_rarity = {
		"-": Item.ItemRarity.NONE,
		"обычный": Item.ItemRarity.COMMON,
		"обычная": Item.ItemRarity.COMMON,
		"обычное": Item.ItemRarity.COMMON,
		"необычный": Item.ItemRarity.UNCOMMON,
		"необычная": Item.ItemRarity.UNCOMMON,
		"необычное": Item.ItemRarity.UNCOMMON,
		"редкий": Item.ItemRarity.RARE,
		"редкая": Item.ItemRarity.RARE,
		"редкое": Item.ItemRarity.RARE,
		"очень редкий": Item.ItemRarity.VERY_RARE,
		"очень редкая": Item.ItemRarity.VERY_RARE,
		"очень редкое": Item.ItemRarity.VERY_RARE,
		"легендарный": Item.ItemRarity.LEGENDARY,
		"легендарная": Item.ItemRarity.LEGENDARY,
		"легендарное": Item.ItemRarity.LEGENDARY
	}
	return choose_rarity[rarity_string]
	
func add_custom(name, chars : Dictionary):
	pass
	
func get_max_custom_id():
	var max_id = 70000 
	var items = {}
	if FileAccess.file_exists("res://database/custom.json"):
		var save_string = FileAccess.open("res://database/custom.json",FileAccess.READ)
		items = JSON.parse_string(save_string.get_as_text())
	else:
		items = {}
	for item in items:
		max_id = max(items[item]["id"], max_id)
	return max_id
