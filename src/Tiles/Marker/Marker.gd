# Setup class type
extends "res://SpriteShading/SpriteShadedSpacial.gd"
const rb_texture = preload("marker.png")
const lb_texture = preload("marker.png")
const lf_texture = preload("marker.png")
const rf_texture = preload("marker.png")

func _process(delta):
	update_tex()


func _on_Marker_body_entered(body):
	if Levels.current_level+1 < Levels.levels.size():
		Levels.current_level += 1
	get_tree().reload_current_scene()
	#if "orig" in body:
	#	body.position(body.orig)
