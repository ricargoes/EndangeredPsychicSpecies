extends Node2D

export var n_cells = Vector2(10, 10)
export var cells_size = Vector2(256, 256)
export var spacing = 1
export(float, 1) var shortcuts_amount = 0.2
export(Array, Array, Vector2) var open_cells
var _default_cell = {"collection":"city", "type": 15}

var cellmap = {}

const DOWN_BIT = 1
const RIGHT_BIT = 2
const UP_BIT = 4
const LEFT_BIT = 8
var _cell_bitwise_walls = {
	Vector2.UP: UP_BIT, 
	Vector2.LEFT: LEFT_BIT, 
	Vector2.RIGHT: RIGHT_BIT, 
	Vector2.DOWN: DOWN_BIT
}

func _ready():
	randomize()
	make_blank_map()
	make_maze()

func make_blank_map():
	for i in range(0, n_cells.x):
		for j in range(0, n_cells.y):
			var coords = Vector2(i, j)
			var cell = _default_cell.duplicate()
			for open_cell in open_cells:
				if coords == open_cell[0]:
					cell["type"] -= _cell_bitwise_walls[open_cell[1]]
			set_cell(coords, cell)

func make_maze():
	var unvisited = []
	var stack = []
	for i in range(0, n_cells.x, spacing):
		for j in range(0, n_cells.y, spacing):
			unvisited.append(Vector2(i, j))
	var current_coords = Vector2.ZERO
	unvisited.erase(current_coords)
	
	while unvisited:
		var unvisited_neighbours = get_unvisited_neighbours(current_coords, unvisited)
		
		if unvisited_neighbours:
			stack.append(current_coords)
			
			var next_coords = unvisited_neighbours[randi() % unvisited_neighbours.size()]
			var dir = (next_coords - current_coords)/spacing
			
			var current_cell = get_cell(current_coords)
			current_cell["type"] -= _cell_bitwise_walls[dir]
			var next_cell = get_cell(next_coords)
			next_cell["type"] -= _cell_bitwise_walls[-dir]
			
			set_cell(current_coords, current_cell)
			set_cell(next_coords, next_cell)
			_fill_gaps(current_coords, dir)
			
			current_coords = next_coords
			unvisited.erase(current_coords)
		elif stack:
			current_coords = stack.pop_back()
	make_shortcuts()

func _fill_gaps(current_coords, dir):
	var cell_type
	for i in range(1, spacing):
		if dir.x != 0:
			cell_type = 5
		elif dir.y != 0:
			cell_type = 10
		current_coords += dir
		var cell = get_cell(current_coords)
		cell["type"] = cell_type
		set_cell(current_coords, cell)

func make_shortcuts():
	for i in range(n_cells.x*n_cells.y*shortcuts_amount):
		var x = int(rand_range(1, (n_cells.x-1)/spacing))*spacing
		var y = int(rand_range(1, (n_cells.y-1)/spacing))*spacing
		var coords = Vector2(x, y)
		var cell = get_cell(coords)
		var dir = _cell_bitwise_walls.keys()[randi() % _cell_bitwise_walls.size()]
		var neighbour_cell = get_cell(coords+dir)
		
		if cell["type"] & _cell_bitwise_walls[dir]:
			cell["type"] -= _cell_bitwise_walls[dir]
			neighbour_cell["type"] -= _cell_bitwise_walls[-dir]
			
			set_cell(coords, cell)
			set_cell(coords+dir, neighbour_cell)

func get_endpoints():
	var endpoints = []
	for coords in cellmap.keys():
		if cellmap[coords]["type"] in [14, 13, 11, 7]:
			endpoints.append(coords)
	return endpoints

func get_unvisited_neighbours(cell_coordinates, unvisited):
	var list = []
	for dir in _cell_bitwise_walls.keys():
		var dir_scalated = dir*spacing
		if cell_coordinates+dir_scalated in unvisited:
			list.append(cell_coordinates+dir_scalated)
	return list

func set_cell(cell_coordinates, cell_data):
	if "node" in cell_data:
		cell_data["node"].queue_free()
	var cell_instance = get_cell_instance(cell_data)
	cell_instance.set_position(cell_coordinates*cells_size)
	add_child(cell_instance)
	cell_data["node"] = cell_instance
	cellmap[cell_coordinates] = cell_data

func get_cell(cell_coordinates):
	return cellmap[cell_coordinates].duplicate()

func get_cell_instance(cell_data):
	var roll = randi() % 100
	var posible_cells = ResourceManager.cells[ cell_data["collection"] ][ cell_data["type"] ]
	var instance
	for candidate_cell in posible_cells:
		if not "chance" in candidate_cell or roll < candidate_cell["chance"]:
			instance = candidate_cell["node"].instance()
			break
	return instance
