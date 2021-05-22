extends Spatial

onready var LevelName = get_node("LevelText/Container/LevelName")
onready var LevelHint = get_node("LevelText/Container/LevelHint")
onready var FinishLabel = get_node("Finish").find_node("Label")

# Load all the tiles
#const Platform = preload("Tiles/Cube/Cube.tscn")
const Platform = preload("res://Tiles/Platform/Platform.tscn")
const Staircase = preload("res://Tiles/StaircaseThin/StaircaseThin.tscn")
const Marker = preload("res://Tiles/Marker/Marker.tscn")
var block_map = [
	null, 
	Platform.instance(), 
	Staircase.instance(), 
	Staircase.instance().set_dir(-1,1),
	Staircase.instance().set_dir(1,-1), 
	Staircase.instance().set_dir(-1,-1),
	Marker.instance()
]

var obj_list = []

# Prepare the player
onready var player = self.find_node("Player")

func _ready():
	get_tree().paused = false
	obj_list.append(player)
	var level = Levels.levels[Levels.current_level]
	
	# Add the text
	LevelName.text = level["Name"]
	LevelHint.text = level["HintText"]
	
	# Construct the map
	if level.has("ConstMap"):
		construct_level(level["ConstMap"])
	elif level.has("FuncMap"):
		var level_array = Levels.callv(level["FuncMap"], level["MapParams"])
		construct_level(level_array)
	player.position(player.orig)

func _input(event):
	if event.is_action_pressed("ui_rotate"):
		var rot_mat = Basis()
		rot_mat = rot_mat.rotated(Vector3(0,1,0), PI/2)
		player.orig = rot_mat*player.orig
		for element in obj_list:
			element.rot()

func finish_line():
	get_tree().paused = true
	#get_node("AnimationPlayer").play("Message")
	if Levels.victory:
		FinishLabel.text = "Congratulations!"
	else:
		FinishLabel.text = "Oops!"
	get_node("Finish").show()

func construct_level(level_array):
	var offset = Vector3()
	offset.x = (level_array[0][0].size()-1)/2.0
	offset.y = (level_array.size()-1)/2.0 + 2
	offset.z = (level_array[0].size()-1)/2.0
	player.orig = offset+Vector3(0,1-2*offset.y,0)
	for y in level_array.size():
		for z in level_array[y].size():
			for x in level_array[y][z].size():
				var block_type = block_map[level_array[y][z][x]]
				if block_type != null:
					var block = block_type.duplicate()
					block.position(Vector3(x,y,z)-offset)
					self.add_child(block)
					obj_list.append(block)
