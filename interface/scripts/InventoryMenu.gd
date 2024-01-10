extends Control


var item_card_scene = preload("res://interface/scenes/InventoryItemCard.tscn")
var item_desc_scene = preload("res://interface/scenes/ItemDescriptionMenu.tscn")
@onready var grid = $ItemsTable/ItemsPanel/ScrollContainer/ItemsContainer
var save: Dictionary

var use_filter: bool
var filter: Item.ItemCategory


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
	
	
	var items_id = items_raw.split(", ")
	var count = count_raw.split(", ")
	for i in range(len(items_id)):
		if len(items_id[i]) <= 0:
			continue
		CurrentInventory.items[Dab.item_by_id(items_id[i])] = int(count[i])
		
	CurrentInventory.set_money(Money.new(int(money[0]),int(money[1]), int(money[2])))
	_update_items()
	_update_money()
	_update_weight()


func _update_items():
	for old_item in grid.get_children():
		grid.remove_child(old_item)

	for new_item in CurrentInventory.items.keys():
		if use_filter and new_item.category != filter:
			continue
		var item_card = item_card_scene.instantiate()
		item_card.set_item(new_item)
		item_card.me_pressed.connect(_on_item_desc_opened)
		grid.add_child(item_card)


func _update_money():
	var inv_money = CurrentInventory.get_money()
	$MoneyPanel/GoldenLabel.text = str(inv_money.golden)
	$MoneyPanel/SilverLabel.text = str(inv_money.silver)
	$MoneyPanel/CopperLabel.text = str(inv_money.copper)


func _update_weight():
	$WeightPanel/WeightLabel.text = str(CurrentInventory.get_total_weight())


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


func _on_item_desc_opened(item: Item):
	var desc_card = item_desc_scene.instantiate()
	desc_card.set_item(item)
	desc_card.me_closed.connect(_on_item_desc_closed)
	add_child(desc_card)
	$BGMenu._on_item_desc_opened()


func _on_item_desc_closed():
	_update_items()
	_update_money()
	_update_weight()
	$BGMenu._on_item_desc_closed()


func _on_change_scene_pressed():
	var newScene: PackedScene = ResourceLoader.load(
		"res://interface/scenes/CharactersMenu.tscn")
	get_tree().change_scene_to_packed(newScene)
	
	

