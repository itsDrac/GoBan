@tool
extends PanelContainer

@onready var card_name = $VBC/CardName
@onready var chapter_name = $VBC/ChapterName
@onready var chapter_des = $VBC/ChapterDes

var chapter: Control

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func show_screen(cd_name: StringName):
	visible = true
	card_name.text = cd_name
	chapter_name.text = chapter.heading.text
	chapter_des.text = chapter.description.text

func _on_close_button_pressed():
	chapter_name.clear()
	chapter_des.clear()
	visible = false
	chapter = null

func connect_ch(ch: PanelContainer):
	chapter = ch


func _on_save_button_pressed():
	chapter.edit_details(
		[chapter_name.text,
		chapter_des.text]
	)
	_on_close_button_pressed()
