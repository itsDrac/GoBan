@tool
extends HBoxContainer

@onready var board_list = $BoardList
@onready var add_board_btn = $BoardList/AddBoard

const res_path = "res://addons/goban/Scripts/side_bar_data.gd"

var boards : Dictionary

signal board_added(board_btn: Button)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func add_board(nm: StringName, cards:=[]):
	boards[boards.size()+1] = nm
	_add_board_btn(nm, cards)

func _add_board_btn(btn_text, cards):
	var btn = Button.new()
	btn.text = btn_text
	btn.toggle_mode = true
	btn.theme_type_variation = &"board_btn"
	btn.button_group = load("res://addons/goban/Assests/Resources/Board_button_group.tres")
	board_list.add_child(btn)
	board_added.emit(btn, cards)

func on_save(res):
	res.boards = boards

func on_load(res):
	for board in res.boards:
		var nm = res.boards[board]
		add_board(nm, res.cards[nm])
