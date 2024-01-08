extends Control


signal update_money

var old_money: Money
var action_money: Money
var new_money: Money
var action: EditMoneyAction

enum EditMoneyAction {
	ADD,
	REDUCE,
	SET,
}


func _on_money_button_pressed():
	visible = true
	_init_old_money()
	_init_action_money()
	_update_new_money()


func _init_old_money():
	var inv_money = CurrentInventory.get_money()
	old_money = Money.new(inv_money.golden, inv_money.silver, inv_money.copper)


func _init_action_money():
	$GoldenInput.text = "0"
	$SilverInput.text = "0"
	$CopperInput.text = "0"
	action_money = Money.new(0, 0, 0)


func _on_action_money_changed():
	_update_new_money()


func _update_new_money():
	_update_action_money()
	_calculate_new_money()
	# TO-DO: Change button color
	$AcceptButton.disabled = not new_money.is_valid()


func _update_action_money():
	action_money.golden = int($GoldenInput.text)
	action_money.silver = int($SilverInput.text)
	action_money.copper = int($CopperInput.text)


func _calculate_new_money():
	match action:
		EditMoneyAction.ADD:
			new_money = Money.new(
				old_money.golden + action_money.golden,
				old_money.silver + action_money.silver,
				old_money.copper + action_money.copper
			)
		EditMoneyAction.REDUCE:
			new_money = Money.new(
				old_money.golden - action_money.golden,
				old_money.silver - action_money.silver,
				old_money.copper - action_money.copper
			)
		EditMoneyAction.SET:
			new_money = Money.new(
				action_money.golden,
				action_money.silver,
				action_money.copper
			)
		_:
			print("what the fuck")


func _on_accept_pressed():
	visible = false
	_update_inv_money()
	
	
func _update_inv_money():
	CurrentInventory.set_money(new_money)
	update_money.emit()
	

func _on_cancel_pressed():
	visible = false
	

func _on_action_changed(new_action: String):
	_set_action(new_action)


func _set_action(new_action: String):
	action = EditMoneyAction[new_action]
	_update_new_money()
