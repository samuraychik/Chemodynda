extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_text_changed(new_text: String):
	if new_text.length() > 0:
		if new_text[0] == "0":
			delete_char_at_caret()

		for symbol in new_text:
			if not symbol.is_valid_int():
				delete_char_at_caret()
				break


func _on_bg_panel_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		var rect = get_global_rect()
		var mouse_pos = get_global_mouse_position()
		if not rect.has_point(mouse_pos):
			editable = false
			release_focus()

func _on_focus_entered():
	editable = true
