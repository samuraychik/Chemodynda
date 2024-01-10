extends Control

signal item_card_pressed(item: Item)

var item: Item


func set_item(new_item: Item):
	item = new_item
	update_card()


func update_card():
	$ItemNameButton._on_item_button_text_changed(item.item_name)
	_update_money_labels()
	_update_category_image()
	_update_magical_status()


func _update_money_labels():
	$MoneyContainer/Golden/GoldenLabel.text = str(item.cost.golden)
	$MoneyContainer/Silver/SilverLabel.text = str(item.cost.silver)
	$MoneyContainer/Copper/CopperLabel.text = str(item.cost.copper)


func _update_category_image():
	match item.category:
		Item.ItemCategory.WEAPON:
			$CategoryImage.texture = load("res://interface/sprites/Weapon.png")
		Item.ItemCategory.ARMOR:
			$CategoryImage.texture = load("res://interface/sprites/Armor.png")
		Item.ItemCategory.TOOL:
			$CategoryImage.texture = load("res://interface/sprites/Tool.png")
		Item.ItemCategory.POISON:
			$CategoryImage.texture = load("res://interface/sprites/Poison.png")
		Item.ItemCategory.MAGICAL:
			$CategoryImage.texture = load("res://interface/sprites/Trinket.png")
		Item.ItemCategory.OTHER:
			$CategoryImage.texture = load("res://interface/sprites/Other.png")


func _update_magical_status():
	var new_stylebox = StyleBoxFlat.new()
	if item.is_magical:
		new_stylebox.bg_color = Color8(242, 212, 250)
		new_stylebox.border_width_top = 3
		new_stylebox.border_width_bottom = 3
		new_stylebox.border_width_right = 3
		new_stylebox.border_width_left = 3
		new_stylebox.border_color = Color8(207, 99, 235)
	else:
		new_stylebox.bg_color = Color8(255, 255, 255)
		new_stylebox.border_width_top = 2
		new_stylebox.border_width_bottom = 2
		new_stylebox.border_width_right = 2
		new_stylebox.border_width_left = 2
		new_stylebox.border_color = Color8(0, 0, 0, 96)

	new_stylebox.corner_radius_bottom_left = 30
	new_stylebox.corner_radius_top_left = 30
	new_stylebox.corner_radius_bottom_right = 30
	new_stylebox.corner_radius_top_right = 30
	$BGPanel.add_theme_stylebox_override("panel", new_stylebox)


func _on_item_card_pressed():
	item_card_pressed.emit(item)

