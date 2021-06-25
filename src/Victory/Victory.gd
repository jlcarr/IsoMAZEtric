extends Control

func _ready():
	get_node("ColorInverter").visible = Levels.darkmode

func _on_Menu_pressed():
	Levels.current_level = 0
	get_tree().change_scene("res://Menu/Menu.tscn")


func _on_RandomLevels_pressed():
	Levels.current_level = Levels.victory_level + 1
	get_tree().change_scene("res://Main/Main.tscn")


func _on_DarkMode_pressed():
	Levels.darkmode = not Levels.darkmode
	get_node("ColorInverter").visible = Levels.darkmode
