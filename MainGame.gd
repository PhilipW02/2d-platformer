extends Node2D
@onready var _player1 = $Stage/Player1
@onready var _player2 = $Stage/Player2

func _ready() -> void:
	choose_tagger()

func choose_tagger():
	var player_number = RandomNumberGenerator.new().randi_range(0, 1)
	if player_number == 0:
		_player1.istagger = true
		_player1.can_tag = true
	else:
		_player2.istagger = true
		_player2.can_tag = true

func tagged(tagger, player_number):
	tagger.istagger = false
	player_number.istagger = true

# Additions
# working Timer
# Teleport appear timer (random?)
# make timer transparent-ish when player is close

# Things to fix
# entered_teleporter prints even when teleporter is not visible

# Links
# https://phantom-camera.dev/follow-modes/group
