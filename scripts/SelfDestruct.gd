extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func on_confirm_self_destruct_button_pressed():
	var scene = get_parent().get_parent().get_parent()
	scene.queue_free()

