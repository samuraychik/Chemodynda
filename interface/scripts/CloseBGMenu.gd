extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_adding_money_menu_hidden():
	visible = false

func _on_available_items_menu_hidden():
	visible = false

func _on_add_item_button_pressed():
	visible = true

func _on_money_button_pressed():
	visible = true
