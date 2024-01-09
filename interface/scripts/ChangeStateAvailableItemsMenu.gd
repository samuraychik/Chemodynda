extends Control


func _on_return_button_pressed():
	visible = false
	
func _on_add_item_button_pressed():
	visible = true

func _close_available_items_menu():
	visible = false
