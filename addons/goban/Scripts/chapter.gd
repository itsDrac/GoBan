@tool
extends PanelContainer

@onready var heading = $MarginContainer/VBoxContainer/Heading
@onready var description = $MarginContainer/VBoxContainer/Description

signal editied(details: Array[StringName])
signal show_editor
signal connect_to_editscreen

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_to_editscreen.emit(self)
	show_editor.emit(self)

func edit_details(details):
	heading.text = details[0]
	description.text = details[1]
	editied.emit(details)

func _on_delete_pressed():
	queue_free()
