extends Control

func on_change_scene_pressed():
	var newScene: PackedScene = ResourceLoader.load("res://interface/scenes/InventoryMenu.tscn")
	get_tree().change_scene_to_packed(newScene)

func on_return_pressed():
	var newScene: PackedScene = ResourceLoader.load("res://interface/scenes/CharactersMenu.tscn")
	get_tree().change_scene_to_packed(newScene)
