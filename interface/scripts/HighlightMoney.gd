extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color8(0, 0, 0)

func _on_money_button_mouse_entered():
	modulate = Color8(255, 0, 0)

func _on_money_button_mouse_exited():
	modulate = Color8(0, 0, 0)
