# Setup class type
extends "res://SpriteShading/SpriteShadedSpacial.gd"
const rb_texture = preload("marker.png")
const lb_texture = preload("marker.png")
const lf_texture = preload("marker.png")
const rf_texture = preload("marker.png")

func _process(delta):
	update_tex()
