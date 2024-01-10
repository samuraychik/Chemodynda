extends Control


var internal_name: String
var preset_name: String
var save = {}
var presets = {}


var save_file_path = "user://save/"
var save_file_name = "save_test.json"


func verify_save_dir(path: String):
	DirAccess.make_dir_absolute(path)


func _ready():
	verify_save_dir(save_file_path)


func set_preset_name(new_name: String):
	internal_name = new_name
	preset_name = new_name.replace("preset", "")
	$PickButton.text = preset_name


func on_pressed():
	_save_new_char()

	var newScene: PackedScene = ResourceLoader.load("res://interface/scenes/InventoryMenu.tscn")
	CurrentInventory.set_char_name(preset_name)
	get_tree().change_scene_to_packed(newScene)
	

func _save_new_char():
	var presets_string = FileAccess.open("res://database/presets.json", FileAccess.READ)
	presets = JSON.parse_string(presets_string.get_as_text())

	var save_string = FileAccess.open(save_file_path + save_file_name, FileAccess.READ)
	save = JSON.parse_string(save_string.get_as_text())

	save[preset_name] = presets[internal_name]

	var new_save_string = FileAccess.open(save_file_path + save_file_name, FileAccess.WRITE)
	var json_string = JSON.stringify(save, " ", 4)
	new_save_string.store_string(json_string)
