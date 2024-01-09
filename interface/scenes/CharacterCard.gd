extends Control
var save_name
signal character_deleted
signal character_renamed

# Called when the node enters the scene tree for the first time.
func _ready():
	save_name = "eblanchik"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_delete():
	character_deleted.emit(save_name)
	
func on_rename(new_name):
	character_renamed.emit(save_name, new_name)
	save_name = new_name
	
