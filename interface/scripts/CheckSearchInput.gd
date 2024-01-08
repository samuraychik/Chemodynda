extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_text_changed(new_text:String):
	var regex = RegEx.new()
	regex.compile("^[a-zA-Zа-яА-Я0-9 ]*$")
	if not regex.search(new_text):
		delete_char_at_caret()
	
	var font: Font = load("res://interface/fonts/Alabama Regular.ttf")
	var text_size = font.get_string_size(new_text)
	if text_size.x > 240:
		delete_char_at_caret()
