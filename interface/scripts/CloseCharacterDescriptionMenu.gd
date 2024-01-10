extends Control


signal me_closed

var item: Item


func set_item(new_item: Item):
	item = new_item
	$ChangingItemCountWindow.set_item(new_item)
	_update_desc()


func _update_desc():
	$ItemNameLabel.text = item.item_name
	$DescriptionTextEdit.text = item.description
	$CopperValueLabel.text = str(item.cost.copper)
	$SilverValueLabel.text = str(item.cost.silver)
	$GoldValueLabel.text = str(item.cost.golden)
	$WeightValueLabel.text = str(item.weight)
	$CountValueLabel.text = str(CurrentInventory.get_item_count(item))
	_update_category()
	_update_magical_status()


func _update_category():
	match item.category:
		Item.ItemCategory.WEAPON:
			$CategoryTypeLabel.text = "Оружие"
		Item.ItemCategory.ARMOR:
			$CategoryTypeLabel.text = "Защита"
		Item.ItemCategory.TOOL:
			$CategoryTypeLabel.text = "Инструмент"
		Item.ItemCategory.POISON:
			$CategoryTypeLabel.text = "Яд"
		Item.ItemCategory.MAGICAL:
			$CategoryTypeLabel.text = "Магический"
		Item.ItemCategory.OTHER:
			$CategoryTypeLabel.text = "Другое"


func _update_magical_status():
	if item.is_magical:
		$MagicalLabel.text = "Магический"
	else:
		$MagicalLabel.text = "Не магический"


func _on_return_button_pressed():
	me_closed.emit()
	queue_free()
