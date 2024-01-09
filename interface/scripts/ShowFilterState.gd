extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_current_category_label_update_filter_state(new_state: String):
	if new_state == "normal":
		texture_normal = load("res://interface/sprites/FilterBlack.png")
		texture_disabled = load("res://interface/sprites/FilterBlack.png")
		texture_hover = load("res://interface/sprites/FilterRed.png")
	elif new_state == "picked":
		texture_normal = load("res://interface/sprites/FilterRed.png")
		texture_disabled= load("res://interface/sprites/FilterRed.png")
		texture_focused= load("res://interface/sprites/FilterRed.png")
		texture_pressed = load("res://interface/sprites/FilterRed.png")
		texture_hover = load("res://interface/sprites/FilterRed.png")
