extends Control

onready var SoundButton = get_node("MenuIconBar/SoundMode")

func _ready():
	SoundButton.set_pressed(AudioController.mute)
	get_node("ColorInverter").visible = Levels.darkmode


func start():
	get_tree().change_scene("res://Main/Main.tscn")


func _input(event):
	if event.is_action_pressed("ui_accept"):
		start()


func _on_DarkMode_pressed():
	Levels.darkmode = not Levels.darkmode
	get_node("ColorInverter").visible = Levels.darkmode


func _on_SoundMode_toggled(button_pressed):
	AudioController.set_mute(button_pressed)
