extends TextureButton


func on_confirm_self_destruct_button_pressed():
	var scene = get_parent().get_parent().get_parent()
	scene.queue_free()
