extends Spatial

const Levels = preload("Levels.gd").levels

# Load all the tiles
#const Cube = preload("Tiles/Cube/Cube.tscn")
const Platform = preload("Tiles/Platform/Platform.tscn")
const Staircase = preload("Tiles/StaircaseThin/StaircaseThin.tscn")
var block_map = [
	null, 
	Platform.instance(), 
	Staircase.instance(), 
	Staircase.instance().set_dir(-1,1),
	Staircase.instance().set_dir(1,-1), 
	Staircase.instance().set_dir(-1,-1),
]

var obj_list = []

# Prepare the player
onready var player = self.find_node("Player")

func _ready():
	obj_list.append(player)
	player.position(Vector3(0,1,0))
	
	construct_level(Levels[2]["ConstMap"])

func _input(event):
	if event.is_action_pressed("ui_rotate"):
		for element in obj_list:
			element.rot()

func construct_level(level_array):
	var offset = Vector3()
	offset.x = level_array[0][0].size()/2
	#offset.y = level_array.size()/2
	offset.z = level_array[0].size()/2
	for y in level_array.size():
		for z in level_array[y].size():
			for x in level_array[y][z].size():
				var block_type = block_map[level_array[y][z][x]]
				if block_type != null:
					var block = block_type.duplicate()
					block.position(Vector3(x,y,z)-offset)
					self.add_child(block)
					obj_list.append(block)
