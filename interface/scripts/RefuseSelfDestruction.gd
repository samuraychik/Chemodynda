extends Node


func on_refuse_button():
	var self_destruct_menu = get_parent().get_parent()
	self_destruct_menu.visible = false
