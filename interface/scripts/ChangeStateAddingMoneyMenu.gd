extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_accept_pressed():
	#
	visible = false

func _on_cancel_pressed():
	visible = false

func _on_money_button_pressed():
	visible = true
