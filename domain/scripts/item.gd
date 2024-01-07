class_name Item
extends Node


var id: int
var item_name: String
var description: String
var category: ItemCategory
var rarity: ItemRarity
var cost: Money
var weight: float
var is_magical: bool

enum ItemCategory {
	WEAPON,
	ARMOR,
	SHIELD,
	TOOL,
	TRINKET,
	POISON,
	OTHER,
}

enum ItemRarity {
	NONE,
	COMMON,
	UNCOMMON,
	RARE,
	VERY_RARE,
	LEGENDARY,
	ARTIFACT,
}


func _init(init_id: int, init_name: String, init_desc: String, \
init_category: Item.ItemCategory, init_rarity: Item.ItemRarity, \
init_cost: Money, init_weight: float, init_magical: bool):
	id = init_id
	item_name = init_name
	description = init_desc
	category = init_category
	rarity = init_rarity
	cost = init_cost
	weight = init_weight
	is_magical = init_magical


func get_cost_of_count(count: int) -> Money:
	return cost.get_multiple(count)
