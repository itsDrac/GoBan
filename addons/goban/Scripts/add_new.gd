@tool
extends PanelContainer

@onready var board_text = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/LineEdit

signal new_name(board_name: StringName)

# Called when the node enters the scene tree for the first time.
func _ready():
	board_text.grab_focus()


func verify_name(nm: String) ->String:
	return nm.strip_edges().capitalize()
	


func _on_add_pressed():
	var nm = verify_name(board_text.text)
	new_name.emit(nm)



func _on_cancel_pressed():
	queue_free()


func _on_board_name_text_submitted(new_text):
	var nm = verify_name(new_text)
	new_name.emit(nm)
