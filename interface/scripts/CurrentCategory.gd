extends Control


func _on_category_chosen(category_name: String):
	self.text = category_name
	visible = true


func _on_filter_button_pressed():
	visible = false


func _on_pick_category_button_pressed():
	visible = false
