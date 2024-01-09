extends Control


var item_card_scene = preload("res://interface/scenes/InventoryItemCard.tscn")
@onready var grid = $ItemsTable/ItemsPanel/ScrollContainer/ItemsContainer
var save : Dictionary

func _ready():
	# load items here
	CurrentInventory.add_item(Item.new(
		1,
		"test",
		"test_d",
		Item.ItemCategory.OTHER,
		Item.ItemRarity.COMMON,
		Money.new(0, 0, 0),
		24,
	), 5)
	CurrentInventory.add_item(Item.new(
		1,
		"test",
		"test_d",
		Item.ItemCategory.OTHER,
		Item.ItemRarity.COMMON,
		Money.new(0, 0, 0),
		14,
	), 2)
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
