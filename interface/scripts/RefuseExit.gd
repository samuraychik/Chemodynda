extends TextureButton


func on_refuse_button():
	var bg_exit_panel = get_parent().get_parent().get_child(1, false)
	var exit_panel = get_parent().get_parent().get_child(2, false)
	bg_exit_panel.visible = false
	exit_panel.visible = false
