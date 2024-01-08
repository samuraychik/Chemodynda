class_name ArmorItem
extends Item


var armor_type: ArmorType
var armor_class: int
var stealth_debuff: bool

enum ArmorType {
	LIGHT,
	MEDIUM,
	HEAVY,
	SHIELD
}


func _init(
	init_id: int,
	init_name: String, init_desc: String,
	init_category: Item.ItemCategory,
	init_rarity: Item.ItemRarity,
	init_cost: Money, init_weight: float,
	init_armor_type: ArmorItem.ArmorType,
	init_armor_class: int,
	init_stealth_debuff: bool
	):
		super(
			init_id, init_name, init_desc, init_category,
			init_rarity, init_cost, init_weight
			)

		armor_type = init_armor_type
		armor_class = init_armor_class
		stealth_debuff = init_stealth_debuff
