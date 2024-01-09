extends Control


var item_card_scene = preload("res://interface/scenes/InventoryItemCard.tscn")
@onready var grid = $ItemsTable/ItemsPanel/ScrollContainer/ItemsContainer
var save: Dictionary

var use_filter: bool
var filter: Item.ItemCategory


func _ready():
	# load items here
	use_filter = false
	CurrentInventory.add_item(Item.new(
		1,
		"test",
		"test_d",
		Item.ItemCategory.OTHER,
		Item.ItemRarity.COMMON,
		Money.new(0, 0, 0),
		24,
	), 5)
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
	print(items_raw, count_raw, money_raw)

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


func _on_change_scene_pressed():
	var newScene: PackedScene = ResourceLoader.load(
		"res://interface/scenes/CharactersMenu.tscn")
	get_tree().change_scene_to_packed(newScene)
