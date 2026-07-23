extends Control

func Select_Test_Level() -> void:
	get_tree().change_scene_to_file("res://Test_Level.tscn")

func Select_Level1() -> void:
	get_tree().change_scene_to_file("res://GrassLevel.tscn")
