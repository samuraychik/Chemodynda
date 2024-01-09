extends LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_text_changed(new_text: String):
	if new_text.length() > 0:
		for symbol in new_text:
			if symbol == ".":
				delete_char_at_caret()
				insert_text_at_caret(",")
			elif not symbol.is_valid_int() and symbol != ",":
				delete_char_at_caret()
				break
