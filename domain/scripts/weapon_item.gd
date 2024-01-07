class_name WeaponItem
extends Item


var damage_type: DamageType
var damage_dice: DamageDice
var dice_count: int

enum DamageType {
	PIERCING,
	SLASHING,
	BLUDGEONING
}

enum DamageDice {
	D4,
	D6,
	D8,
	D10,
	D12,
	D20,
	D100
}


func _init(init_id: int, init_name: String, init_desc: String, \
init_category: Item.ItemCategory, init_rarity: Item.ItemRarity, \
init_cost: Money, init_weight: float, init_magical: bool, \
init_damage_type: WeaponItem.DamageType, \
init_damage_dice: WeaponItem.DamageDice, \
init_dice_count: int):
	super(init_id, init_name, init_desc, init_category, \
	init_rarity, init_cost, init_weight, init_magical)
	
	damage_type = init_damage_type
	damage_dice = init_damage_dice
	dice_count = init_dice_count
