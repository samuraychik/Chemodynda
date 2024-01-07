extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func on_closing_button_pressed():
	visible = false

func on_open_button_pressed():
	visible = true
