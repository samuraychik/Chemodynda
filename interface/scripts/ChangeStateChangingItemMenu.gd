extends Control


signal item_removed

var item: Item
var old_money: Money
var new_money: Money


func set_item(new_item: Item):
	item = new_item


func _on_cancel_button_pressed():
	visible = false


func _on_accept_button_pressed():
	if $ChangeBuingStateButton2.button_pressed:
		CurrentInventory.set_money(new_money)
	CurrentInventory.remove_item(item, int($CountInput.text))
	
	item_removed.emit()
	visible = false


func _on_change_button_pressed():
	visible = true
	_init_money()
	_autofill()


func _autofill():
	$CopperInput.text = str(item.cost.copper)
	$SilverInput.text = str(item.cost.silver)
	$GoldenInput.text = str(item.cost.golden)
	$CountInput.text = ""
	$ChangeBuingStateButton2.button_pressed = false


func _init_money():
	old_money = CurrentInventory.get_money()
	_update_money()


func _update_money():
	var price = Money.new(int($GoldenInput.text), int($SilverInput.text), int($CopperInput.text))
	var total_price = price.get_multiple(int($CountInput.text))
	new_money = Money.new(
		old_money.golden + total_price.golden,
		old_money.silver + total_price.silver,
		old_money.copper + total_price.copper
	)

	$AcceptButton.disabled = int($CountInput.text) < 1 \
	or int($CountInput.text) > CurrentInventory.get_item_count(item)
