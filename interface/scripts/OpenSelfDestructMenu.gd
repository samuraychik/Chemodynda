extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func on_self_destruct_button_pressed():
	var self_destruct_menu = get_parent().get_child(get_child_count() - 1)
	self_destruct_menu.visible = true