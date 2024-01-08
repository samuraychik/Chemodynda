class_name Inventory
extends Node


signal negative_item_count

var items: Dictionary
var money: Money


func _init():
	# new empty inventory
	items = {}
	money = Money.new(0, 0, 0)


func add_item(item: Item, count: int):
	if not item in items.keys():
		items[item] = 0
	items[item] += count


func remove_item(item: Item, count: int):
	var new_count = items[item] - count
	if new_count < 0:
		negative_item_count.emit()
	elif new_count == 0:
		items.erase(item)
	else:
		items[item] = new_count


func get_item_count(item: Item) -> int:
	return items[item]


func get_money() -> Money:
	return Money.new(money.golden, money.silver, money.copper)


func set_money(new_money: Money):
	money = Money.new(new_money.golden, new_money.silver, new_money.copper)


func get_total_weight() -> float:
	var total = 0
	for item in items.keys():
		total += item.weight
	return total
