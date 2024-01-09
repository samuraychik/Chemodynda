extends Control


var item_card_scene = preload("res://interface/scenes/InventoryItemCard.tscn")
@onready var grid = $ItemsTable/ItemsPanel/ScrollContainer/ItemsContainer
var save : Dictionary

func _ready():
	CurrentInventory.items = {}
	var char_name = CurrentInventory.get_char_name()
	$CharacterInventoryName.text = char_name
	
	if FileAccess.file_exists("res://database/save_test.json"):
		var save_string = FileAccess.open("res://database/save_test.json",FileAccess.READ)
		save = JSON.parse_string(save_string.get_as_text())
	else:
		save = {}
	var char_save = save[char_name] 
	var items_raw = char_save["items"]
	var count_raw = char_save["count"]
	var money_raw = char_save["money"]
	
	var money = money_raw.split(" ")
	CurrentInventory.set_money(Money.new(int(money[0]),int(money[1]), int(money[2])))
	
	var items_id = items_raw.split(", ")
	var count = count_raw.split(", ")
	for i in range(len(items_id)):
		if len(items_id[i]) <= 0:
			continue
		var new_item = find_item(items_id[i])
		var new_item_name = new_item[0]
		var new_item_chars = new_item[1]
		match items_id[i][0]:
			"1":
				CurrentInventory.add_item(Item.new(
					new_item_chars["id"],
					new_item_name,
					"",
					Item.ItemCategory.ARMOR,
					Item.ItemRarity.NONE,
					parse_money(new_item_chars["cost"]),
					int(new_item_chars["weight"].replace(" фнт.", "")),
				), int(count[i]))
			"2":
				CurrentInventory.add_item(Item.new(
					new_item_chars["id"],
					new_item_name,
					"",
					Item.ItemCategory.WEAPON,
					Item.ItemRarity.NONE,
					parse_money(new_item_chars["cost"]),
					int(new_item_chars["weight"].replace(" фнт.", "")),
				), int(count[i]))
			"3":
				CurrentInventory.add_item(Item.new(
					new_item_chars["id"],
					new_item_name,
					new_item_chars["description"],
					Item.ItemCategory.OTHER,
					Item.ItemRarity.NONE,
					parse_money(new_item_chars["cost"]),
					int(new_item_chars["weight"].replace(" фнт.", "")),
				), int(count[i]))
			"5":
				CurrentInventory.add_item(Item.new(
					new_item_chars["id"],
					new_item_name,
					new_item_chars["description"],
					Item.ItemCategory.POISON,
					Item.ItemRarity.NONE,
					parse_money(new_item_chars["cost"]),
					int(new_item_chars["weight"].replace(" фнт.", "")),
				), int(count[i]))
			"6":
				CurrentInventory.add_item(Item.new(
					new_item_chars["id"],
					new_item_name,
					new_item_chars["description"],
					Item.ItemCategory.MAGICAL,
					parse_rarity(new_item_chars["rarity"]),
					parse_money(new_item_chars["cost"]),
					int(new_item_chars["weight"].replace(" фнт.", "")),
				), int(count[i]))
	
	_update_items()
	_update_money()
	_update_weight()


func _update_items():
	for item in CurrentInventory.items.keys():
		var item_card = item_card_scene.instantiate()
		item_card.set_item(item)
		grid.add_child(item_card)


func _update_money():
	var inv_money = CurrentInventory.get_money()
	$MoneyPanel/GoldenLabel.text = str(inv_money.golden)
	$MoneyPanel/SilverLabel.text = str(inv_money.silver)
	$MoneyPanel/CopperLabel.text = str(inv_money.copper)


func _update_weight():
	$WeightPanel/WeightLabel.text = str(CurrentInventory.get_total_weight())


func _on_change_scene_pressed():
	var newScene: PackedScene = ResourceLoader.load(
		"res://interface/scenes/CharactersMenu.tscn")
	get_tree().change_scene_to_packed(newScene)
	
	
func find_item(id):
	var choose_file = {
		"1": "armor.json",
		"2": "weapon.json",
		"3": "equip.json",
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
		"обычное": Item.ItemRarity.COMMON,
		"необычный": Item.ItemRarity.UNCOMMON,
		"необычное": Item.ItemRarity.UNCOMMON,
		"редкий": Item.ItemRarity.RARE,
		"редкое": Item.ItemRarity.RARE,
		"очень редкий": Item.ItemRarity.VERY_RARE,
		"очень редкое": Item.ItemRarity.VERY_RARE,
		"легендарный": Item.ItemRarity.LEGENDARY,
		"легендарное": Item.ItemRarity.LEGENDARY
	}
	return choose_rarity[rarity_string]
