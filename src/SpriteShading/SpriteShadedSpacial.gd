extends Spatial

func _ready():
	var Mesh = get_node("MeshInstance")
	var SpriteMaterial = Mesh.get_surface_material(0).duplicate()
	Mesh.set_surface_material(0, SpriteMaterial)

func position(pos):
	self.transform.origin = 2*pos
	update_tex()
	return self

func get_pos():
	return self.transform.origin/2

func rot():
	# Reposition
	var rot_mat = Basis()
	rot_mat = rot_mat.rotated(Vector3(0,1,0), PI/2)
	self.position(rot_mat*self.get_pos())
	
	# Redirection
	var new_rot = self.get_rotation().y + PI/2
	var new_rot_deg = int(round(180*new_rot/PI))
	new_rot_deg = ((new_rot_deg % 360) + 360) % 360
	var lr = 1
	var fb = 1
	if new_rot_deg == 90 or new_rot_deg == 270:
		lr = -1
	if new_rot_deg == 180 or new_rot_deg == 270:
		fb = -1
	self.set_dir(lr, fb)

func update_tex():
	var material = get_node("MeshInstance").get_surface_material(0)
	material.set_shader_param("pos", self.transform.origin/2)

func set_dir(lr=1,fb=1):
	self.set_rotation(Vector3())
	var Mesh = get_node("MeshInstance")
	var SpriteMaterial = Mesh.get_surface_material(0).duplicate()
	Mesh.set_surface_material(0, SpriteMaterial)
	if lr == 1 and fb == 1:
		self.rotate_y(0)
		SpriteMaterial.set_shader_param("sprite", self.rb_texture)
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
