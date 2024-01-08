class_name Money
extends Node


var golden: int
var silver: int
var copper: int


func is_valid() -> bool:
	return golden >= 0 and silver >= 0 and copper >= 0


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
