extends Control

signal close_available_items_menu


func _on_add_custom_item_button_pressed():
	visible = true

func _on_accept_pressed():
	#
	emit_signal("close_available_items_menu")
	visible = false

func _on_cancel_pressed():
	visible = false
