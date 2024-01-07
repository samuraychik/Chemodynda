extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func open_exit_menu():
	var bg_exit_panel = get_parent().get_child(1, false)
	var exit_panel = get_parent().get_child(2, false)
	bg_exit_panel.visible = true
	exit_panel.visible = true


