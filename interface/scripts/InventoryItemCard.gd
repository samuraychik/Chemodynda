extends Control


var item: Item


func set_item(new_item: Item):
	item = new_item
	update_card()


func update_card():
	$ItemNameButton.text = item.item_name
	$WeightLabel.text = str(item.weight)
	$CountLabel.text = str(CurrentInventory.get_item_count(item))
	# TO-DO:
	# - description
	# - price
	# - category icon
	# - magical
