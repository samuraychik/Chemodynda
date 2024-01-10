extends Control


@onready var child_basement = $Presets/ScrollContainer/VBoxContainer
var presets = {}
var save = {}
var card_scene = preload("res://interface/scenes/PresetCard.tscn")

var save_file_path = "user://save/"
var save_file_name = "save_test.json"


func verify_save_dir(path: String):
	DirAccess.make_dir_absolute(path)


func _ready():
	verify_save_dir(save_file_path)

	var save_string = FileAccess.open(save_file_path + save_file_name, FileAccess.READ)
	save = JSON.parse_string(save_string.get_as_text())

	var presets_string = FileAccess.open("res://database/presets.json", FileAccess.READ)
	presets = JSON.parse_string(presets_string.get_as_text())

	for name in presets:
		var card = card_scene.instantiate()
		card.set_preset_name(name)
		child_basement.add_child(card)


func on_change_scene_pressed():
	var empty_save = {
		"count": "",
		"items": "",
		"money": "0 0 0"
	}
	var empty_name = "Новый пустой"
	save[empty_name] = empty_save
	var new_save_string = FileAccess.open(save_file_path + save_file_name, FileAccess.WRITE)
	var json_string = JSON.stringify(save, " ", 4)
	new_save_string.store_string(json_string)
	
	CurrentInventory.set_char_name(empty_name)
	var newScene: PackedScene = ResourceLoader.load("res://interface/scenes/InventoryMenu.tscn")
	get_tree().change_scene_to_packed(newScene)


func on_return_pressed():
	var newScene: PackedScene = ResourceLoader.load("res://interface/scenes/CharactersMenu.tscn")
	get_tree().change_scene_to_packed(newScene)
