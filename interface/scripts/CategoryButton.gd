extends Button

signal accept_category(category_name: String)


func _on_pressed():
	accept_category.emit(text)
	get_parent().get_parent().visible = false
