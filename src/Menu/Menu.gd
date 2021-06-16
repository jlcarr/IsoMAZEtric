extends Control

func start():
	get_tree().change_scene("res://Main/Main.tscn")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		start()
