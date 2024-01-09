extends Control

signal item_added
var og_item: Item
var from_dab: bool
var old_money: Money
var new_money: Money


func on_item_card_pressed(item: Item):
	visible = true
	_init_money()
	from_dab = true
	og_item = item
	_autofill()


func _init_money():
	old_money = CurrentInventory.get_money()
	_update_new_money()


func _update_new_money():
	var price = Money.new(int($GoldenInput.text), int($SilverInput.text), int($CopperInput.text))
	var total_price = price.get_multiple(int($CountInput.text))
	new_money = Money.new(
		old_money.golden - total_price.golden,
		old_money.silver - total_price.silver,
		old_money.copper - total_price.copper
	)
	$AcceptButton.disabled = $BuyButton.button_pressed and not new_money.is_valid()


func _autofill():
	$ItemNameInput.text = og_item.item_name
	$DescriptionTextEdit.text = og_item.description
	$WeightInput.text = str(og_item.weight)
	$GoldenInput.text = str(og_item.cost.golden)
	$SilverInput.text = str(og_item.cost.silver)
	$CopperInput.text = str(og_item.cost.copper)
	$MagicalButton.button_pressed = og_item.is_magical
	_fill_category()


func _fill_category():
	match og_item.category:
		Item.ItemCategory.WEAPON:
			$ScrollContainer/Categories/WeaponButton._on_pressed()
		Item.ItemCategory.ARMOR:
			$ScrollContainer/Categories/ArmorButton._on_pressed()
		Item.ItemCategory.TOOL:
			$ScrollContainer/Categories/ToolButton._on_pressed()
		Item.ItemCategory.POISON:
			$ScrollContainer/Categories/PoisonButton._on_pressed()
		Item.ItemCategory.MAGICAL:
			$ScrollContainer/Categories/MagicalButton._on_pressed()
		Item.ItemCategory.OTHER:
			$ScrollContainer/Categories/OtherButton._on_pressed()

func _get_category() -> Item.ItemCategory:
	match $PickCategoryButton.text:
		"Оружие":
			return Item.ItemCategory.WEAPON
		"Защита":
			return Item.ItemCategory.ARMOR
		"Инструмент":
			return Item.ItemCategory.TOOL
		"Яд":
			return Item.ItemCategory.POISON
		"Магический":
			return Item.ItemCategory.MAGICAL
		"Другое":
			return Item.ItemCategory.OTHER
		_:
			return Item.ItemCategory.OTHER


func _get_cost() -> Money:
	return Money.new(
		int($GoldenInput.text),
		int($SilverInput.text),
		int($CopperInput.text)
		)


func _on_add_custom_item_button_pressed():
	visible = true
	$GoldenInput.text = ""
	$SilverInput.text = ""
	$CopperInput.text = ""
	_init_money()
	from_dab = false


func _on_accept_pressed():
	if from_dab and _is_unchanged():
		_add_to_inventory(og_item)
	else:
		var new_item = Item.new(
			Dab.get_max_custom_id(),
			"*" + $ItemNameInput.text,
			$DescriptionTextEdit.text,
			_get_category(),
			Item.ItemRarity.NONE,
			_get_cost(),
			int($WeightInput.text),
			$MagicalButton.button_pressed
		)
		_add_to_inventory(new_item)
		Dab.add_custom(new_item)

	item_added.emit()
	visible = false


func _is_unchanged() -> bool:
	var cost = _get_cost()
	return og_item.item_name == $ItemNameInput.text \
	and og_item.description == $DescriptionTextEdit.text \
	and og_item.category == _get_category() \
	and og_item.cost.golden == cost.golden \
	and og_item.cost.silver == cost.silver \
	and og_item.cost.copper == cost.copper \
	and og_item.weight == int($WeightInput.text) \
	and og_item.is_magical == $MagicalButton.button_pressed


func _add_to_inventory(item: Item):
	if $BuyButton.button_pressed:
		CurrentInventory.set_money(new_money)
	CurrentInventory.add_item(item, int($CountInput.text))


func _on_cancel_pressed():
	visible = false
