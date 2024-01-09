extends Button

signal accept_category
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_pressed():
	emit_signal("accept_category", text)
	get_parent().get_parent().visible = false
