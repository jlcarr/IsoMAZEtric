extends Node

var darkmode = false
var soundmode = true

var current_level = 0

var victory = false
var victory_level = 8

var rng = RandomNumberGenerator.new()
var rng_state = rng.get_state()
func _ready():
	rng.randomize()


func level_up():
	if victory and self.current_level == victory_level:
		victory = false
		get_tree().paused = false
		get_tree().change_scene("res://Victory/Victory.tscn")
		return
		
	if victory and self.current_level < victory_level:
		self.current_level += 1
	
	if not victory:
		rng.set_state(rng_state)
	
	victory = false
	get_tree().paused = false
	get_tree().reload_current_scene()


const levels = [
	{
		"Name": "Level 0: Hello World",
		"HintText": "Use the arrow keys to move toward the arrow.",
		"ConstMap": 
			[
				[
					[1,1,1],
					[1,1,1],
					[1,1,1]
				],
				[
					[6,0,0],
					[0,0,0],
					[0,0,0]
				]
			]
	},
	{
		"Name": "Level 1: Keep It Up!",
		"HintText": "Climb the steps to your goal.",
		"ConstMap": 
			[
				[
					[0,0,0],
					[0,0,0],
					[0,0,1]
				],
				[
					[0,0,1],
					[0,0,2],
					[1,3,0]
				],
				[
					[1,3,0],
					[2,0,0],
					[0,0,0]
				],
				[
					[6,0,0],
					[0,0,0],
					[0,0,0]
				]
			]
	},
	{
		"Name": "Level 2: Blind Corner",
		"HintText": "Press SHIFT to rotate and get a better view!",
		"ConstMap": 
			[
				[
					[1,1,1,0,0,1],
					[1,0,1,1,0,1],
					[1,0,0,0,0,1],
					[1,1,1,0,0,1],
					[1,1,1,1,1,1],
					[1,1,1,1,1,1]
				],
				[
					[0,0,0,0,3,0],
					[0,0,0,6,3,0],
					[0,0,0,0,3,0],
					[0,0,0,0,3,0],
					[0,0,0,0,3,0],
					[0,0,0,0,0,0]
				],
				[
					[0,0,0,3,0,0],
					[0,0,0,3,0,0],
					[0,0,0,3,0,0],
					[0,0,0,3,0,0],
					[0,0,0,3,0,0],
					[0,0,0,0,0,0],
				],
				[
					[0,0,3,0,0,0],
					[0,0,3,0,0,0],
					[0,0,3,0,0,0],
					[0,0,3,0,0,0],
					[0,0,3,0,0,0],
					[0,0,0,0,0,0],
				],
				[
					[1,3,0,0,0,0],
					[1,3,0,0,0,0],
					[1,3,0,0,0,0],
					[1,3,0,0,0,0],
					[1,3,0,0,0,0],
					[0,0,0,0,0,0],
				]
			]
	},
	{
		"Name": "Level 3: The Ivory Tower",
		"HintText": "Carry on upward!",
		"ConstMap": 
			[
				[
					[0,0,0],
					[0,0,0],
					[0,0,1]
				],
				[
					[0,0,1],
					[0,0,2],
					[0,0,0]
				],
				[
					[1,3,0],
					[0,0,0],
					[0,0,0]
				],
				[
					[0,0,0],
					[4,0,0],
					[1,0,0]
				],
				[
					[0,0,0],
					[0,0,0],
					[0,5,1]
				],
				[
					[0,0,1],
					[0,0,2],
					[0,0,0]
				],
				[
					[1,3,0],
					[0,0,0],
					[0,0,0]
				],
				[
					[0,0,0],
					[4,0,0],
					[1,0,0]
				],
				[
					[0,0,0],
					[0,0,0],
					[0,5,1]
				],
				[
					[0,0,0],
					[0,0,0],
					[0,0,6]
				]
			]
	},
	{
		"Name": "Level 4: Leap Of Faith",
		"HintText": "Sometimes you'll need to jump off the beaten path to reach your goals.",
		"ConstMap": 
			[
				[
					[1,0,0,0,0,0,1],
				],
				[
					[6,0,0,0,0,3,0],
				],
				[
					[0,0,0,0,3,0,0],
				],
				[
					[0,0,0,3,0,0,0],
				],
				[
					[0,1,3,0,0,0,0],
				],
			]
	},
	{
		"Name": "Level 5: Ups And Downs",
		"HintText": "Sometimes life takes you up, down and around.",
		"ConstMap": 
			[
				[
					[0,0,0],
					[0,0,0],
					[1,0,1]
				],
				[
					[1,0,0],
					[2,0,0],
					[0,3,0]
				],
				[
					[0,5,1],
					[0,0,0],
					[0,0,0]
				],
				[
					[0,0,0],
					[0,0,4],
					[1,0,1]
				],
				[
					[1,0,0],
					[2,0,0],
					[0,3,0]
				],
				[
					[0,5,1],
					[0,0,0],
					[0,0,0]
				],
				[
					[0,0,6],
					[0,0,0],
					[0,0,0]
				]
			]
	},
	{
		"Name": "Level 6: A Matter Of Perspective",
		"HintText": "Beware illusions of perspective and false endings!",
		"ConstMap": 
			[
				[
					[1,1,0,0,0,0,0],
					[0,0,0,0,0,0,0],
					[0,0,0,0,0,0,0],
					[0,0,0,0,0,0,1],
				],
				[
					[6,0,0,0,0,0,0],
					[0,0,0,0,0,0,0],
					[0,0,0,0,0,0,2],
					[0,0,0,0,0,0,0],
				],
				[
					[0,0,0,0,0,0,1],
					[0,0,0,0,0,0,2],
					[0,0,0,0,0,0,0],
					[0,0,0,0,0,0,0],
				],
				[
					[0,0,1,1,1,3,0],
					[0,0,0,0,1,0,0],
					[0,0,0,0,1,0,0],
					[0,0,0,0,1,0,0],
				]
			]
	},
	{
		"Name": "Level 7: Super Symmetry",
		"HintText": "Even as the world turns around you, sometimes it can look like nothing has changed.",
		"ConstMap":
			[
				[
					[1,1,0,0,0,1],
					[0,0,0,0,0,1],
					[0,0,0,0,0,0],
					[0,0,0,0,0,0],
					[1,0,0,0,0,0],
					[1,0,0,0,1,1],
				],
				[
					[6,0,5,1,0,0],
					[0,0,1,0,0,0],
					[1,0,0,0,1,4],
					[2,1,0,0,0,1],
					[0,0,0,1,0,0],
					[0,0,1,3,0,0],
				],
				[
					[0,0,0,0,0,0],
					[0,0,0,0,0,0],
					[0,0,4,3,0,0],
					[0,0,5,2,0,0],
					[0,0,0,0,0,0],
					[0,0,0,0,0,0],
				],
			]
	},
	{
		"Name": "Level 8: Lost In The Lattice",
		"HintText": "Explore and rotate carefully to build up your mental map.",
		"ConstMap": 
			[
				[
					[1,0,0,0,1],
					[0,0,0,0,0],
					[0,0,1,0,0],
					[0,0,0,0,0],
					[1,0,0,0,1]
				],
				[
					[0,5,1,3,0],
					[0,0,2,0,0],
					[1,3,0,0,1],
					[0,0,4,0,2],
					[0,5,1,3,0]
				],
				[
					[1,0,0,0,1],
					[2,0,0,0,0],
					[0,0,1,3,0],
					[4,0,0,0,0],
					[1,0,0,0,1]
				],
				[
					[0,5,1,3,0],
					[0,0,0,0,0],
					[1,0,0,0,1],
					[0,0,0,0,2],
					[0,0,1,0,0]
				],
				[
					[1,0,0,0,1],
					[2,0,4,0,2],
					[0,0,1,3,0],
					[4,0,2,0,0],
					[1,3,0,5,1]
				],
				[
					[6,0,0,0,0],
					[0,0,0,0,0],
					[0,0,0,0,0],
					[0,0,0,0,0],
					[0,0,0,0,0]
				]
			]
	},
	{
		"Name": "Level ???: Random Walk",
		"HintText": "Explore!",
		"FuncMap": "random_walk",
		"MapParams": [Vector3(6,6,6), 2*6*6*6]
	}
]


func random_walk(dim, walk_len):
	# Initialize the map to empty
	var level_array = []
	for i in dim.y:
		var sub_plat = []
		for j in dim.z:
			var sub_row = []
			for k in dim.x:
				sub_row.append(-1)
			sub_plat.append(sub_row)
		level_array.append(sub_plat)
	
	# Initial position
	var pos = Vector3(dim.x-1, 1, dim.z-1)
	level_array[pos.y-1][pos.z][pos.x] = 1
	level_array[pos.y][pos.z][pos.x] = 0
	
	# Random walk
	for step in walk_len:
		var choices = []
		for move in valid_moves[level_array[pos.y-1][pos.z][pos.x]]:
			var new_pos = pos + move["dpos"]
			if check_bounds(new_pos, dim) and \
				check_bounds(new_pos + Vector3(0,-1,0), dim) and \
				[-1, 0].has(level_array[new_pos.y][new_pos.z][new_pos.x]) and \
				[-1, move["tile"]].has(level_array[new_pos.y-1][new_pos.z][new_pos.x]):
				choices.append(move)
		if choices.empty():
			break
		var choice = choices[rng.randi() % choices.size()]
		pos = pos + choice["dpos"]
		if pos.y + 1 < dim.y and level_array[pos.y+1][pos.z][pos.x] == -1:
			level_array[pos.y+1][pos.z][pos.x] = 0
		level_array[pos.y][pos.z][pos.x] = 0
		level_array[pos.y-1][pos.z][pos.x] = choice["tile"]
	level_array[pos.y][pos.z][pos.x] = 6
	
	# Final cleanup
	for y in level_array.size():
		for z in level_array[y].size():
			for x in level_array[y][z].size():
				if level_array[y][z][x] == -1:
					level_array[y][z][x] = 0
	return level_array


func check_bounds(pos, dim):
	return pos.x >= 0 and pos.x < dim.x and \
		pos.y >= 0 and pos.y < dim.y and \
		pos.z >= 0 and pos.z < dim.z


const valid_moves = {
	1 : [
		{"dpos": Vector3(1,0,0), "tile": 1},
		{"dpos": Vector3(-1,0,0), "tile": 1},
		{"dpos": Vector3(0,0,1), "tile": 1},
		{"dpos": Vector3(0,0,-1), "tile": 1},
		{"dpos": Vector3(0,1,-1), "tile": 2},
		{"dpos": Vector3(0,0,1), "tile": 2},
		{"dpos": Vector3(-1,1,0), "tile": 3},
		{"dpos": Vector3(1,0,0), "tile": 3},
		{"dpos": Vector3(0,1,1), "tile": 4},
		{"dpos": Vector3(0,0,-1), "tile": 4},
		{"dpos": Vector3(1,1,0), "tile": 5},
		{"dpos": Vector3(-1,0,0), "tile": 5},
	],
	2: [
		{"dpos": Vector3(0,1,-1), "tile": 2},
		{"dpos": Vector3(0,0,-1), "tile": 1},
		{"dpos": Vector3(0,-1,1), "tile": 2},
		{"dpos": Vector3(0,-1,1), "tile": 1},
	],
	3: [
		{"dpos": Vector3(-1,1,0), "tile": 3},
		{"dpos": Vector3(-1,0,0), "tile": 1},
		{"dpos": Vector3(1,-1,0), "tile": 3},
		{"dpos": Vector3(1,-1,0), "tile": 1},
	],
	4: [
		{"dpos": Vector3(0,1,1), "tile": 4},
		{"dpos": Vector3(0,0,1), "tile": 1},
		{"dpos": Vector3(0,-1,-1), "tile": 4},
		{"dpos": Vector3(0,-1,-1), "tile": 1},
	],
	5: [
		{"dpos": Vector3(1,1,0), "tile": 5},
		{"dpos": Vector3(1,0,0), "tile": 1},
		{"dpos": Vector3(-1,-1,0), "tile": 5},
		{"dpos": Vector3(-1,-1,0), "tile": 1},
	],
}
