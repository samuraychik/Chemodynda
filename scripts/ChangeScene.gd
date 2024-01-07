extends Control

var scenes = []

func _ready():
    scenes = ["Characters.tscn", "Presets.tscn", "Inventory.tscn"]

func on_change_scene_pressed(number_scene : int):
    var newScene: PackedScene = ResourceLoader.load("res://scenes/main_scenes/%s" % scenes[number_scene])
    get_tree().change_scene_to_packed(newScene)
