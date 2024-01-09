extends Control


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

func _on_category_chosen():
	visible = false

func _on_pick_category_button_pressed():
	visible = true

func _on_changing_item_count_window_hidden():
	visible = false

func _on_change_button_pressed():
	visible = true
