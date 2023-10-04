@tool
extends VBoxContainer

@onready var add_btn = $AddBtn
@onready var board_name = $BoardName
@onready var card_list = $MC/CardList
@onready var edit_chapter = $MC/EditChapter

const card_path = preload("res://addons/goban/Scenes/card.tscn")
var card_node: PanelContainer
var cards:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func toggle_visible(to: bool):
	visible = to

func connect_to_board(board_btn: Button, saved_cards):
	board_name.text = board_btn.text
	board_btn.toggled.connect(toggle_visible)
	for card in saved_cards:
		add_card(card)

func add_card(card_name: StringName):
	cards.append(card_name)
	_add_card_node(card_name)

func _add_card_node(card_name):
	card_node = card_path.instantiate()
	card_list.add_child(card_node)
	card_node.ch_editor = edit_chapter
	card_node.card_name.text = card_name

func show_edit_chapter(cd_name, ch):
	edit_chapter.show_screen(cd_name, ch)

func on_load(res):
	print_debug(res.cards[board_name.text])

func on_save(res):
	res.cards[board_name.text] = cards
