extends Node2D
@onready var _player1 = $Player1
@onready var _player2 = $Player2

func _ready() -> void:
	choose_tagger()

func choose_tagger():
	var player_number = RandomNumberGenerator.new().randi_range(0, 1)
	if player_number == 0:
		_player1.istagger = true
	else:
		_player2.istagger = true

func tagged(tagger, player_number):
	tagger.istagger = false
	player_number.istagger = true
