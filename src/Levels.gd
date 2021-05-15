extends Node

# Consider using callv for generator functions

const levels = [
	{
		"Name": "",
		"HintText": "",
		"ConstMap": 
			[
				[
					[1,1,],
					[1,1,]
				],
				[
					[0,0],
					[3,2]
				]
			],
		"GenFunc": ""
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
			],
		"GenFunc": ""
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
			],
		"GenFunc": ""
	}
]


func random_walk(x_l, y_l, z_l, walk_len):
	var map = []
	for i in x_l:
		var sub_plat = []
		for j in y_l:
			var sub_row = []
			for k in z_l:
				sub_row.append(0)
			sub_plat.append(sub_row)
		map.append(sub_plat)
	pass
