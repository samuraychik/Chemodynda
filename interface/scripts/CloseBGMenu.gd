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
	
func _on_filter_button_pressed():
	visible = true

func _on_category_7_accept_category(new_text: String):
	visible = false

func _on_category_1_accept_category(new_text: String):
	visible = false

func _on_category_2_accept_category(new_text: String):
	visible = false

func _on_category_3_accept_category(new_text: String):
	visible = false

func _on_category_4_accept_category(new_text: String):
	visible = false

func _on_category_5_accept_category(new_text: String):
	visible = false

func _on_category_6_accept_category(new_text: String):
	visible = false

func _on_pick_category_button_pressed():
	visible = true
