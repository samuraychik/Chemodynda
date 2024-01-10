extends LineEdit

var picking_button: Button
var was_changed: bool
# Called when the node enters the scene tree for the first time.
func _ready():
	was_changed = false
	picking_button = get_parent().get_child(get_child_count() - 2)

func on_rename_button_pressed():
	picking_button.visible = false
	was_changed = true
	text = ""
	editable = true

func _on_gui_input(event:InputEvent):
	if event is InputEventMouseButton and event.pressed and was_changed:
		var rect = get_global_rect()
		if not rect.has_point(get_global_mouse_position()):
			editable = false
			picking_button.visible = true
			if text != "":
				picking_button.text = text
			else:
				text = picking_button.text
			was_changed = false
			release_focus()

func _on_text_submitted(new_text:String):
	editable = false
	picking_button.visible = true
	if new_text != "":
		picking_button.text = new_text
	else:
		text = picking_button.text
	was_changed = false
	release_focus()

func _on_text_changed(new_text:String):
	var font: Font = load("res://interface/fonts/Alabama Regular.ttf")
	var text_size = font.get_string_size(new_text)
	if text_size.x > 240:
		delete_char_at_caret()
