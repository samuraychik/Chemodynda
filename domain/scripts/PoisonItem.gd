class_name PoisonItem
extends Item


var poison_type: PoisonType

enum PoisonType {
	CONTACT,
	INGESTED,
	INHALED,
	INJURY,
}

func _init(
	init_id: int,
	init_name: String, init_desc: String,
	init_category: Item.ItemCategory,
	init_rarity: Item.ItemRarity,
	init_cost: Money, init_weight: float, init_magical: bool,
	init_poison_type: PoisonItem.PoisonType):
		super(
			init_id, init_name, init_desc, init_category,
			init_rarity, init_cost, init_weight, init_magical
			)
		poison_type = init_poison_type
