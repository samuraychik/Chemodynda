extends Control


func open_exit_menu():
	var bg_exit_panel = get_parent().get_child(1, false)
	var exit_panel = get_parent().get_child(2, false)
	bg_exit_panel.visible = true
	exit_panel.visible = true
