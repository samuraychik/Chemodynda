extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	text = get_parent().get_child(get_child_count() - 3).text

