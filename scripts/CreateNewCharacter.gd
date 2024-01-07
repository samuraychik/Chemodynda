extends Node

var max_count_characters = 20
var style_box = StyleBoxFlat.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	style_box.bg_color = Color8(192, 198, 204)
	style_box.corner_radius_bottom_left = 100
	style_box.corner_radius_top_left = 100
	style_box.corner_radius_top_right = 100
	style_box.corner_radius_bottom_right = 100
	

func on_character_button_pressed():
	if max_count_characters > get_child_count():
		var panel = Panel.new()	
		panel.custom_minimum_size = Vector2(600, 50)
		var style_name = "PanelContainer%s" % (get_child_count() + 1)
		panel.name = style_name
		panel.add_theme_stylebox_override(style_name, style_box)
		add_child(panel)
	elif max_count_characters == get_child_count():
		var label = Label.new()
		label.name = "Память кончилась..."
		label.size = Vector2(100, 100)
		label.modulate = Color8(160, 190, 219)
		add_child(label)
	
	
