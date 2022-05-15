extends Camera2D


const dim_room_i = 40
const dim_room_j = 30
const l = 8

var dim_room_x = dim_room_i*l
var dim_room_y = dim_room_j*l

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_limit_room()
	

func set_limit_room():
	var player = get_parent()
	var i := int(player.position.x / dim_room_x)
	var j := int(player.position.y / dim_room_y)
	
	limit_left = i * dim_room_x
	limit_right = (i+1) * dim_room_x
	
	limit_top = j * dim_room_y
	limit_bottom = (j+1) * dim_room_y
	
