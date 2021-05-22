# Setup class type
extends "res://SpriteShading/SpriteShadedSpacial.gd"
const rb_texture = preload("marker.png")
const lb_texture = preload("marker.png")
const lf_texture = preload("marker.png")
const rf_texture = preload("marker.png")

func _process(delta):
	update_tex()


func _on_Marker_body_entered(body):
	#Levels.level_up()
	get_tree().get_current_scene().finish_line()
	#if "orig" in body:
	#	body.position(body.orig)
