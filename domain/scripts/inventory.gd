class_name Inventory
extends Node


signal negative_item_count

var items: Dictionary
var balance: Money

func _init():
	items = {}

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
