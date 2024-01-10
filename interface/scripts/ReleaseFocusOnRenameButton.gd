extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_character_panel_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		var rect = get_global_rect()
		var mouse_pos = get_global_mouse_position()
		if not rect.has_point(mouse_pos):
			release_focus()

