extends Control

signal character_deleted
signal character_renamed
signal character_selected

var char_name: String


func set_char_name(new_name: String):
	char_name = new_name
	$PickButton.text = char_name


func on_delete():
	character_deleted.emit(char_name)
	
	
func on_rename(new_name):
	character_renamed.emit(char_name, new_name)
	set_char_name(new_name)
	
func on_pressed():
	var newScene: PackedScene = ResourceLoader.load("res://interface/scenes/InventoryMenu.tscn")
	CurrentInventory.set_char_name(char_name)
	get_tree().change_scene_to_packed(newScene)
	
