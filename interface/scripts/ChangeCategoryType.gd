extends Control

signal update_filter_state

func _ready():
	pass
	
func _on_category_1_accept_category(new_text: String):
	self.text = new_text
	visible = true
	emit_signal("update_filter_state", "picked")

func _on_category_2_accept_category(new_text: String):
	self.text = new_text
	visible = true
	emit_signal("update_filter_state", "picked")

func _on_category_3_accept_category(new_text: String):
	self.text = new_text
	visible = true
	emit_signal("update_filter_state", "picked")
	
func _on_category_4_accept_category(new_text: String):
	self.text = new_text
	visible = true
	emit_signal("update_filter_state", "picked")
	
func _on_category_5_accept_category(new_text: String):
	self.text = new_text
	visible = true
	emit_signal("update_filter_state", "picked")
	
func _on_category_6_accept_category(new_text: String):
	self.text = new_text
	visible = true
	emit_signal("update_filter_state", "picked")

func _on_category_7_accept_category(new_text: String):
	self.text = new_text
	visible = true
	emit_signal("update_filter_state", "normal")

func _on_filter_button_pressed():
	visible = false

func _on_pick_category_button_pressed():
	visible = false
