extends Control

@onready var child_basement = $BottomPanel/Characters/ScrollContainer/Characters
var save = {}
var card_scene = preload("res://interface/scenes/CharacterCard.tscn")

var save_file_path = "user://save/"
var save_file_name = "save_test.json"


func verify_save_dir(path: String):
	DirAccess.make_dir_absolute(path)


func _ready():
	verify_save_dir(save_file_path)

	var save_string = FileAccess.open(save_file_path + save_file_name, FileAccess.READ)
	save = JSON.parse_string(save_string.get_as_text())
	
	for name in save:
		var card = card_scene.instantiate()
		card.set_char_name(name)
		card.character_deleted.connect(on_character_death)
		card.character_renamed.connect(on_character_rename)
		child_basement.add_child(card)


func on_character_death(name):
	save.erase(name)
	var new_save_string = FileAccess.open(save_file_path + save_file_name, FileAccess.WRITE)
	var json_string = JSON.stringify(save, " ", 4)
	new_save_string.store_string(json_string)


func on_character_rename(old_name, new_name):
	var new_save = save[old_name].duplicate()
	save.erase(old_name)
	save[new_name] = new_save
	var new_save_string = FileAccess.open(save_file_path + save_file_name, FileAccess.WRITE)
	var json_string = JSON.stringify(save, " ", 4)
	new_save_string.store_string(json_string)


func on_change_scene_pressed(number_scene : int):
	var newScene: PackedScene = ResourceLoader.load("res://interface/scenes/PresetsMenu.tscn")
	get_tree().change_scene_to_packed(newScene)
