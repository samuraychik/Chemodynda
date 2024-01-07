extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_text_changed(new_text:String):
	if new_text.length() > 0:
		if new_text[0] == "0":
			print(1)
			delete_char_at_caret()

		for symbol in new_text:
			if not symbol.is_valid_int():
				delete_char_at_caret()
				break
