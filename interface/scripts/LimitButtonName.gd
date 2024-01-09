extends Button


func _on_button_text_changed(new_text: String):
	var font: Font = load("res://interface/fonts/Alabama Regular.ttf")
	var new_button_text = ""
	var width = 0
	var splited_text = new_text.split(" ")

	for text_block in splited_text:
		var new_block_text = ""
		for symbol in text_block:
			var symbol_width = font.get_string_size(symbol) 
			if width + symbol_width.x > 150:
				self.text = new_button_text + "..."
				return
			else:
				width += symbol_width.x
				new_block_text += symbol
				
		new_button_text += new_block_text
		
		var symbol_width = font.get_string_size(" ") 
		if width + symbol_width.x > 150:
			self.text = new_button_text + "..."
			return 
		else:
			width += symbol_width.x
			new_button_text += " "
			
	self.text = new_text
	
func _on_item_button_text_changed(new_text: String):
	var font: Font = load("res://interface/fonts/Alabama Regular.ttf")
	var new_button_text = ""
	var width = 0
	var splited_text = new_text.split(" ")

	for text_block in splited_text:
		var new_block_text = ""
		for symbol in text_block:
			var symbol_width = font.get_string_size(symbol) 
			if width + symbol_width.x > 220:
				self.text = new_button_text + "..."
				return
			else:
				width += symbol_width.x
				new_block_text += symbol
				
		new_button_text += new_block_text
		
		var symbol_width = font.get_string_size(" ") 
		if width + symbol_width.x > 220:
			self.text = new_button_text + "..."
			return 
		else:
			width += symbol_width.x
			new_button_text += " "
			
	self.text = new_text
	
