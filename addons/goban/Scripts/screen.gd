@tool
extends MarginContainer

var new_screen: Container
var board_screen: Container
@onready var side_bar = $Screen/SideBar
@onready var screen = $Screen
@onready var board_screen_area = $Screen/BoardScreenArea

const new_screen_path = preload("res://addons/goban/Scenes/add_new.tscn")
const board_screen_path = preload("res://addons/goban/Scenes/board_screen.tscn")
const saved_file = "res://addons/goban/Assests/Resources/saved.res"
const SaveTemp = preload("res://addons/goban/Scripts/save_template.gd")

signal save_all
signal load_all

# Called when the node enters the scene tree for the first time.
func _ready():
	ready.connect(check_loaded)
	side_bar.add_board_btn.pressed.connect(_on_add_board_pressed)
	save_all.connect(side_bar.on_save)
	load_all.connect(side_bar.on_load)
	side_bar.board_added.connect(add_board_screen)

func check_loaded():
	if not FileAccess.file_exists(saved_file):
		return
	var res = ResourceLoader.load(saved_file).duplicate(true)
	if res:
		print_debug(res.boards)
		print_debug(res.cards)
		load_all.emit(res)

func _on_add_board_pressed():
	new_screen = new_screen_path.instantiate()
	add_child(new_screen)
	new_screen.new_name.connect(func(nm): 
		side_bar.add_board(nm)
		new_screen.queue_free()
		)
	

func add_board_screen(board_btn, cards=[]):
	board_screen = board_screen_path.instantiate()
	save_all.connect(board_screen.on_save)
#	load_all.connect(board_screen.on_load)
	board_screen_area.add_child(board_screen)
	board_screen.connect_to_board(board_btn, cards)
	board_screen.add_btn.pressed.connect(func():
		connect_add_btn_screen(board_screen)
		)

func connect_add_btn_screen(bs):
	new_screen = new_screen_path.instantiate()
	add_child(new_screen)
	new_screen.new_name.connect(func(nm): 
		bs.add_card(nm)
		new_screen.queue_free()
		)

func _on_show_btn_toggled(button_pressed):
	side_bar.visible = button_pressed

func _on_save_btn_pressed():
	var res = SaveTemp.new()
	save_all.emit(res)
#	res.make_final_board()
#	print_debug(res.final_board)
	ResourceSaver.save(res, saved_file)
	
