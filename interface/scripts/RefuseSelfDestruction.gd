extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_refuse_button():
	var self_destruct_menu = get_parent().get_parent()
	self_destruct_menu.visible = false
