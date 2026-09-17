extends Node2D
@onready var players = get_tree().get_nodes_in_group("players")
@onready var teleporters = get_tree().get_nodes_in_group("teleporters")
@onready var telpos = get_tree().get_nodes_in_group("telpos")

func _ready() -> void:
	get_node("Area2D/CollisionShape2D").disabled = true

func entered_teleporter(_body: Node2D) -> void:
	if _body.is_in_group("players"):
		print("69")
		if _body == players[0]:
			print('player 1', players[0])
			players[0].position = Vector2(0, 0)
			#print(_body.position.distance_to(telpos[0].position))
		if _body == players[1]:
			print('player 2', players[1])
			players[1].position = Vector2(0, 0)
