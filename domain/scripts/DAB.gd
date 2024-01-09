extends Node


func item_by_id(id):
	var float_id = float(id)
	var new_item = find_item(str(float_id))
	var new_item_name = new_item[0]
	var new_item_chars = new_item[1]
	match str(float_id)[0]:
			"1":
				var desc = new_item_chars["type"] + "\n"
				desc += "КД: " + new_item_chars["class"] + "\n"
				desc += "Требуемая сила: " + new_item_chars["strength"] + "\n"
				desc += "Скрытность: " + new_item_chars["stealth"] + "\n"
				return Item.new(
					new_item_chars["id"],
					new_item_name,
					"",
					Item.ItemCategory.ARMOR,
					Item.ItemRarity.NONE,
					parse_money(new_item_chars["cost"]),
					float(new_item_chars["weight"].replace(" фнт.", "")))
			"2":
				var desc = new_item_chars["features"] + "\n"
				desc += "Урон: " + new_item_chars["damage"] + "\n"
				desc += "Тип: " + new_item_chars["type"] + "\n"
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
				var desc = new_item_chars["type"] + "\n" + new_item_chars["description"]
				return Item.new(
					new_item_chars["id"],
					new_item_name,
					desc,
					Item.ItemCategory.TOOL,
					Item.ItemRarity.NONE,
					parse_money(new_item_chars["cost"]),
					float(new_item_chars["weight"].replace(" фнт.", "")))
			"5":
				var desc = new_item_chars["usage"] + "\n" + new_item_chars["description"]
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
			"7":
				return Item.new(
					new_item_chars["id"],
					new_item_name,
					new_item_chars["description"],
					parse_category(new_item_chars["category"]),
					parse_rarity(new_item_chars["rarity"]),
					parse_money(new_item_chars["cost"]),
					float(new_item_chars["weight"].replace(" фнт.", "")))
	
	
func find_item(id):
	var choose_file = {
		"1": "armor.json",
		"2": "weapon.json",
		"3": "equip.json",
		"4": "tool.json",
		"5": "poison.json",
		"6": "magic.json",
		"7": "custom.json"
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
	var moneys = money_string.split(", ") 
	var money = Money.new(0, 0, 0)
	for one_money in moneys:
		if " зм" in one_money:
			money.add_money(Money.new(int(one_money.replace(" зм", "")), 0, 0))
		if " см" in one_money:
			money.add_money(Money.new(0, int(one_money.replace(" см", "")), 0))
		if " мм" in one_money:
			money.add_money(Money.new(0, 0, int(one_money.replace(" мм", ""))))
	return money


func deparse_money(money: Money):
	return str(money.golden) + " зм, " + str(money.silver) + " см, " + str(money.copper) + " мм"


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


func deparse_rarity(rarity):
	var choose_word = {
		Item.ItemRarity.NONE: "-",
		Item.ItemRarity.COMMON: "обычный",
		Item.ItemRarity.UNCOMMON: "необычный",
		Item.ItemRarity.RARE: "редкий",
		Item.ItemRarity.VERY_RARE:"очень редкий",
		Item.ItemRarity.LEGENDARY:"легендарный",
	}
	return choose_word[rarity]


func parse_category(cat_string):
	var cat_choose = {
		"other": Item.ItemCategory.OTHER,
		"armor": Item.ItemCategory.ARMOR,
		"weapon": Item.ItemCategory.WEAPON,
		"tool": Item.ItemCategory.TOOL,
		"poison": Item.ItemCategory.POISON,
		"magical": Item.ItemCategory.MAGICAL
	}
	return cat_choose[cat_string]


func deparse_category(cat_string):
	var cat_choose = {
		Item.ItemCategory.OTHER: "other",
		Item.ItemCategory.ARMOR: "armor",
		Item.ItemCategory.WEAPON: "weapon",
		Item.ItemCategory.TOOL: "tool",
		Item.ItemCategory.POISON: "poison",
		Item.ItemCategory.MAGICAL: "magical"
	}
	return cat_choose[cat_string]


func add_custom(item: Item):
	var id = item.id
	var items = {}
	if FileAccess.file_exists("res://database/custom.json"):
		var save_string = FileAccess.open("res://database/custom.json",FileAccess.READ)
		items = JSON.parse_string(save_string.get_as_text())
	else:
		items = {}
		
	var item_save = {}
	item_save["id"] = id #
	item_save["description"] = item.description
	item_save["rarity"] = deparse_rarity(item.rarity)
	item_save["cost"] = deparse_money(item.cost)
	item_save["category"] = deparse_category(item.category)
	item_save["weight"] = str(item.weight) + " фнт."
	items[item.item_name] = item_save
	
	var new_save_string = FileAccess.open("res://database/custom.json",FileAccess.WRITE)
	var json_string = JSON.stringify(items, " ", 4)
	new_save_string.store_string(json_string)


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
	return max_id + 1
