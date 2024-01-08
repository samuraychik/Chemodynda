class_name ArmoryItem
extends Item


var armory_type: ArmoryType
var armor_class: int
var stealth_debuff: bool

enum ArmoryType {
	LIGHT,
	MEDIUM,
	HEAVY,
}


func _init(init_id: int, init_name: String, init_desc: String, \
init_category: Item.ItemCategory, init_rarity: Item.ItemRarity, \
init_cost: Money, init_weight: float, init_magical: bool, \
init_armory_type: ArmoryItem.ArmoryType, \
init_armor_class: int, \
init_stealth_debuff: bool):
	super(init_id, init_name, init_desc, init_category, \
	init_rarity, init_cost, init_weight, init_magical)
	
	armory_type = init_armory_type
	armor_class = init_armor_class
	stealth_debuff = init_stealth_debuff
