extends Control


var item_card_scene = preload("res://interface/scenes/InventoryItemCard.tscn")
@onready var grid = $ItemsTable/ItemsPanel/ScrollContainer/ItemsContainer


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
	_update_items()
	_update_money()
	_update_weight()


func _update_items():
	for item in CurrentInventory.items.keys():
		var item_card = item_card_scene.instantiate()
		item_card.custom_minimum_size = Vector2(740, 120)
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
		"res://interface/scenes/main_scenes/CharactersMenu.tscn")
	get_tree().change_scene_to_packed(newScene)
