extends Node2D

signal teleporter_entered(teleporter: Sprite2D, player: CharacterBody2D)

func entered_teleporter(_body: Node2D) -> void:
	if _body.is_in_group("players") && _body is CharacterBody2D:
		teleporter_entered.emit(self, _body as CharacterBody2D)
