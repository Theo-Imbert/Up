extends TileMap

const moving_platform_vertical = Vector2(1,0)
const moving_platform_horizontal = Vector2(2,0)
var MOVING_PLATFORM := preload("res://Moving_platform.tscn")
const spike = Vector2(3,0)
const one_way_platform = Vector2(0,1)
var ONE_WAY_PLATFORM := preload("res://One_way_platform.tscn")
const button = Vector2(1,1)
var BUTTON := preload("res://Button.tscn")
const enable_platform = Vector2(2,1)
const disable_platform = Vector2(3,1)

const l = 8

var start := true

var cells_enable_platform = []
var cells_disable_platform = []

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if start:
		create_scene()
		start = false



func create_scene():
	
	for tile in get_used_cells():
		var type = get_cell_autotile_coord(tile.x,tile.y)
		
		if type == moving_platform_horizontal:
			var instance = general_instantiate(MOVING_PLATFORM,tile)
			instance.set_horizontal()
		if type == moving_platform_vertical:
			var instance = general_instantiate(MOVING_PLATFORM,tile)
			
		if type == one_way_platform:
			general_instantiate(ONE_WAY_PLATFORM,tile)
		
		if type == disable_platform:
			cells_disable_platform += [tile]
		if type == enable_platform:
			cells_enable_platform += [tile]
		
		if type == button:
			general_instantiate(BUTTON,tile)
	print(cells_disable_platform)
	print(cells_enable_platform)

func general_instantiate(obj,tile)->Node2D:
	 # erasing prev platform
	erase_platform(tile)
	# instantiate new
	var instance = obj.instance()
	get_tree().get_current_scene().add_child(instance)
	instance.position = tile*l+Vector2(l,l)/2
	return instance

func erase_platform(tile):
	set_cellv(tile,-1)

func activate_platform():
	for tile in cells_disable_platform:
		set_cellv_auto(tile,enable_platform)
	for tile in cells_enable_platform:
		set_cellv_auto(tile,disable_platform)

func reset_platform():
	for tile in cells_disable_platform:
		set_cellv_auto(tile,disable_platform)
	for tile in cells_enable_platform:
		set_cellv_auto(tile,enable_platform)

func set_cellv_auto(tile,type):
	set_cellv(tile,0,false,false,false,type)
	
	
