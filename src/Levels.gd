extends Node

const levels = [
	{
		"Name": "",
		"HintText": "",
		"ConstMap": 
			[
				[
					[1,1],
					[1,1]
				],
				[
					[6,0],
					[3,0]
				]
			]
	},
	{
		"Name": "",
		"HintText": "",
		"ConstMap": 
			[
				[
					[1,1,1],
					[1,1,1],
					[1,1,1]
				]
			]
	},
	{
		"Name": "",
		"HintText": "",
		"ConstMap": 
			[
				[
					[1,1,1,1],
					[1,1,1,1],
					[1,1,1,1],
					[1,1,1,1],
				]
			]
	},
	{
		"Name": "",
		"HintText": "",
		"ConstMap": 
			[
				[
					[1,1,1,1,1],
					[1,1,1,1,1],
					[1,1,1,1,1],
					[1,1,1,1,1],
					[1,1,1,1,1],
				]
			]
	},
	{
		"Name": "",
		"HintText": "",
		"ConstMap": 
			[
				[
					[1,1,1,1,1],
					[1,1,1,1,1],
					[1,1,1,1,2],
					[1,1,1,1,1],
					[1,1,1,1,2],
				],
				[
					[0,0,0,0,0],
					[0,0,0,0,2],
					[0,4,0,0,0],
					[5,0,3,0,0],
					[0,2,0,0,0],
				],
				[
					[5,0,0,0,2],
					[0,0,0,0,0],
					[4,0,0,0,0],
					[0,0,0,0,0],
					[0,0,0,0,0],
				]
			]
	},
	{
		"Name": "",
		"HintText": "",
		"ConstMap":
			[
				[
					[1,1,1,1,1],
					[1,1,1,1,1],
					[1,1,1,1,1],
					[1,1,1,1,1],
					[1,1,1,1,1],
				],
				[
					[0,2,3,4,5],
					[0,0,0,0,0],
					[0,0,0,3,0],
					[0,0,0,3,0],
					[0,0,0,3,0],
				],
				[
					[0,0,0,0,0],
					[0,0,0,0,0],
					[0,0,3,0,0],
					[0,0,3,0,0],
					[0,0,3,0,1],
				],
				[
					[0,0,0,0,0],
					[0,0,0,0,0],
					[1,3,0,0,0],
					[1,3,0,0,0],
					[1,3,0,0,0],
				],
				[
					[0,0,0,0,0],
					[0,0,0,0,0],
					[6,0,0,0,0],
					[0,0,0,0,0],
					[0,0,0,0,0],
				],
			]
	},
	{
		"Name": "",
		"HintText": "",
		"FuncMap": "random_walk",
		"MapParams": [Vector3(6,6,6), 2*6*6*6]
	}
]


func random_walk(dim, walk_len):
	randomize()
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
		var choice = choices[randi() % choices.size()]
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
