extends Control

func _ready():
	get_node("ColorInverter").visible = Levels.darkmode

func start():
	get_tree().change_scene("res://Main/Main.tscn")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		start()

func _on_DarkMode_pressed():
	Levels.darkmode = not Levels.darkmode
	get_node("ColorInverter").visible = Levels.darkmode
