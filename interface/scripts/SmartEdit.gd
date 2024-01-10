extends TextEdit


func _on_focus_entered():
	editable = true


func on_gui_input(event):
	if event is InputEventKey:
		var key_event = event as InputEventKey
		if key_event.is_action("ui_cancel"):
			editable = false
			release_focus()


func _on_bg_panel_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		var rect = get_global_rect()
		var mouse_pos = get_global_mouse_position()
		if not rect.has_point(mouse_pos):
			editable = false
			release_focus()
