extends Control

signal character_deleted
signal character_renamed

var char_name: String


func set_char_name(new_name: String):
	char_name = new_name
	$PickButton.text = char_name


func on_delete():
	character_deleted.emit(char_name)
	
	
func on_rename(new_name):
	character_renamed.emit(char_name, new_name)
	set_char_name(new_name)
	
