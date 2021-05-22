extends PanelContainer


func _input(event):
	if event.is_action_pressed("ui_jump") and get_tree().paused:
		#get_tree().finish_level()
		Levels.level_up()
