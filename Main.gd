extends Spatial

# Load all the tiles
const Cube = preload("Tiles/Cube.tscn")
const Platform = preload("Tiles/Platform.tscn")
const Staircase = preload("Tiles/Staircase/Staircase.tscn")
var block_map = [
	null, 
	Cube.instance(), 
	Staircase.instance(), 
	Staircase.instance().set_dir(1,1),
	Staircase.instance().set_dir(1,-1), 
	Staircase.instance().set_dir(-1,-1),
	Platform.instance()
]

# Prepare the player
onready var player = self.find_node("Player")

# Used to convert discrete tile layout to 3D transformed space
var positioner = Transform(
	Vector3(0.69, 0.817*0.69, 0.69).to_diagonal_matrix(),
	Vector3(0,0,0))


func _ready():
	print(block_map[2].set_dir())
	player.transform.origin = positioner*Vector3(0,4,0)
	
	construct_level([
		[
			[1,1,1,1,1],
			[1,1,1,1,1],
			[1,1,1,1,1],
			[1,1,1,1,1],
			[1,1,1,1,1],
		],
		[
			[1,2,3,4,5],
			[0,0,0,0,0],
			[0,5,0,0,6],
			[0,5,0,0,6],
			[0,5,0,0,6],
		],
		[
			[0,0,0,0,0],
			[0,0,0,0,0],
			[0,0,5,0,0],
			[0,0,5,0,0],
			[0,0,5,0,0],
		],
		[
			[0,0,0,0,0],
			[0,0,0,0,0],
			[0,0,0,5,0],
			[0,0,0,5,0],
			[0,0,0,5,0],
		],
	])

func construct_level(level_array):
	for y in level_array.size():
		for z in level_array[y].size():
			for x in level_array[y][z].size():
				var block_type = block_map[level_array[y][z][x]]
				if block_type != null:
					var block = block_type.duplicate()
					block.transform = block.transform.translated(positioner*Vector3(x,y,z))
					self.add_child(block)
