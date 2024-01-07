class_name Money
extends Node


signal negative_coins

var golden: int:
	get:
		return golden
	set(value):
		if golden < 0:
			negative_coins.emit()
		else:
			golden = value

var silver: int:
	get:
		return silver
	set(value):
		if silver < 0:
			negative_coins.emit()
		else:
			silver = value

var copper: int:
	get:
		return copper
	set(value):
		if copper < 0:
			negative_coins.emit()
		else:
			copper = value


func _init(golden_init, silver_init, copper_init):
	golden = golden_init
	silver = silver_init
	copper = copper_init


func set_money(money: Money):
	golden = money.golden
	silver = money.silver
	copper = money.copper


func add_money(money: Money):
	golden += money.golden
	silver += money.silver
	copper += money.copper


func remove_money(money: Money):
	golden -= money.golden
	silver -= money.silver
	copper -= money.copper


func get_multiple(mult: int) -> Money:
	return Money.new(golden * mult, silver * mult, copper * mult)
