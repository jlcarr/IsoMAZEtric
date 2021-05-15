extends Spatial

func _ready():
	var Mesh = get_node("MeshInstance")
	var SpriteMaterial = Mesh.get_surface_material(0).duplicate()
	Mesh.set_surface_material(0, SpriteMaterial)

func position(pos):
	self.transform.origin = 2*pos
	update_tex()
	return self

func update_tex():
	var material = get_node("MeshInstance").get_surface_material(0)
	material.set_shader_param("pos", self.transform.origin/2)

func set_dir(lr=1,fb=1):
	var Mesh = get_node("MeshInstance")
	var SpriteMaterial = Mesh.get_surface_material(0).duplicate()
	Mesh.set_surface_material(0, SpriteMaterial)
	if lr == -1 and fb == 1:
		self.rotate_y(PI/2)
		SpriteMaterial.set_shader_param("sprite", self.lb_texture)
	if lr == -1 and fb == -1:
		self.rotate_y(-PI/2)
		SpriteMaterial.set_shader_param("sprite", self.lf_texture)
	if lr == 1 and fb == -1:
		self.rotate_y(PI)
		SpriteMaterial.set_shader_param("sprite", self.rf_texture)
	return self
