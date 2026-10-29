extends Area2D
class_name HoverArea2D

@export var speed: Vector2 = Vector2.UP

#signal hoverpad_area_entered(player: CharacterBody2D)

func _ready() -> void:
	body_entered.connect(_on_area_2d_body_entered)
	body_exited.connect(_hoverpad_exited)

func _on_area_2d_body_entered(object: Node2D) -> void:
	if "wind_velocity" in object:
		if speed.y < 0.0:
			object.velocity.y = speed.y
		object.wind_velocity += speed
	#if not str(body).contains('TileMap'):
		#print(body)

func _hoverpad_exited(object: Node2D) -> void:
	pass # Replace with function body.
