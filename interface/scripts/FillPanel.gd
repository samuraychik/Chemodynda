extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	# Цвет для немагического
	var style_box_nonmagical =  StyleBoxFlat.new()
	style_box_nonmagical.bg_color = Color8(255, 255, 255)
	style_box_nonmagical.border_width_top = 2
	style_box_nonmagical.border_width_bottom = 2
	style_box_nonmagical.border_width_right = 2
	style_box_nonmagical.border_width_left = 2
	style_box_nonmagical.border_color = Color8(0, 0, 0, 96)
	style_box_nonmagical.corner_radius_bottom_left = 30
	style_box_nonmagical.corner_radius_top_left = 30
	style_box_nonmagical.corner_radius_bottom_right = 30
	style_box_nonmagical.corner_radius_top_right = 30
	add_theme_stylebox_override("panel", style_box_nonmagical)

	# Цвет для магического
	var style_box_magical =  StyleBoxFlat.new()
	style_box_magical.bg_color = Color8(242, 212, 250)
	style_box_magical.border_width_top = 3
	style_box_magical.border_width_bottom = 3
	style_box_magical.border_width_right = 3
	style_box_magical.border_width_left = 3
	style_box_magical.border_color = Color8(207, 99, 235)
	style_box_magical.corner_radius_bottom_left = 30
	style_box_magical.corner_radius_top_left = 30
	style_box_magical.corner_radius_bottom_right = 30
	style_box_magical.corner_radius_top_right = 30
	add_theme_stylebox_override("panel", style_box_magical)



