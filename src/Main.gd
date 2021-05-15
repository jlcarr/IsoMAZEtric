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

# Prepare the player
onready var player = self.find_node("Player")

func _ready():
	player.transform.origin = Vector3(0,1,0)
	
	construct_level(Levels[1]["ConstMap"])


func construct_level(level_array):
	for y in level_array.size():
		for z in level_array[y].size():
			for x in level_array[y][z].size():
				var block_type = block_map[level_array[y][z][x]]
				if block_type != null:
					#var block = Cube.instance().position(Vector3(x,y,z))
					#print(block)
					#self.add_child(block)
					var block = block_type.duplicate()
					#print(block)
					#print(Vector3(x,y,z))
					block.position(Vector3(x,y,z))
					self.add_child(block)
