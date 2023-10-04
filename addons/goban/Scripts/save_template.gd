@tool
extends Resource

@export var boards: Dictionary
@export var cards: Dictionary

@export var final_board: Dictionary

func make_final_board():
	for board in boards:
		final_board[board] = cards[boards[board]]
