@tool
extends PanelContainer

@onready var card_name = $MC/ChapterList/CardName
@onready var chapter_list = $MC/ChapterList

const chapter_path = preload("res://addons/goban/Scenes/chapter.tscn")
var chapter_node: PanelContainer
#signal show_edit_chapter(cd_name,ch)
var ch_editor: Control

var chapters: Dictionary

signal show_editor
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func add_chapter(details):
	chapters[details[0]]= details[1]

func _on_add_chapter_pressed():
	chapter_node = chapter_path.instantiate()
	chapter_node.editied.connect(add_chapter)
#	chapter_node.connect_to_editscreen.connect(ch_editor.connect_ch)
	chapter_node.show_editor.connect(show_ch_editor)
	chapter_list.add_child(chapter_node)

func show_ch_editor(ch):
	ch_editor.connect_ch(ch)
	ch_editor.show_screen(card_name.text)
