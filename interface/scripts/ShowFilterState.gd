extends TextureButton


func _on_category_chosen(category_name: String):
	if category_name == "Все":
		texture_normal = load("res://interface/sprites/FilterBlack.png")
		texture_disabled = load("res://interface/sprites/FilterBlack.png")
		texture_hover = load("res://interface/sprites/FilterRed.png")
	else:
		texture_normal = load("res://interface/sprites/FilterRed.png")
		texture_disabled= load("res://interface/sprites/FilterRed.png")
		texture_focused= load("res://interface/sprites/FilterRed.png")
		texture_pressed = load("res://interface/sprites/FilterRed.png")
		texture_hover = load("res://interface/sprites/FilterRed.png")
