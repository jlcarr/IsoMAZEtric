extends Control


func _on_Menu_pressed():
	get_tree().change_scene("res://Menu/Menu.tscn")


func _on_RandomLevels_pressed():
	Levels.current_level = Levels.victory_level + 1
	get_tree().change_scene("res://Main/Main.tscn")
