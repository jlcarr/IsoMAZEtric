extends StaticBody
const rb_texture = preload("staircase_rb_sprite.png")
const lf_texture = preload("staircase_lf_sprite.png")
const rf_texture = preload("staircase_rf_sprite.png")

func set_dir(lr=-1,fb=1):
	var CollisionShape = get_node("CollisionShape")
	var SpriteMesh = get_node("SpriteMesh")
	var billboard_material = SpriteMesh.get_surface_material(0).duplicate()
	if lr == 1 and fb == 1:
		CollisionShape.transform = CollisionShape.transform.rotated(Vector3(0,1,0), -PI/2)
		billboard_material.albedo_texture = rb_texture
	if lr == -1 and fb == -1:
		CollisionShape.transform = CollisionShape.transform.rotated(Vector3(0,1,0), PI)
		billboard_material.albedo_texture = lf_texture
	if lr == 1 and fb == -1:
		CollisionShape.transform = CollisionShape.transform.rotated(Vector3(0,1,0), PI/2)
		billboard_material.albedo_texture = rf_texture
	SpriteMesh.set_surface_material(0, billboard_material)
	return self