extends TextureButton


func on_self_destruct_button_pressed():
	var self_destruct_menu = get_parent().get_child(get_child_count() - 1)
	self_destruct_menu.visible = true
