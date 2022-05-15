extends Position2D


var dim = 1
var l = 8

onready var sprite = $KinematicBody2D/Sprite
onready var collision_shape = $KinematicBody2D/CollisionShape2D

func _ready():
	set_dim(dim)
	$AnimationPlayer.advance(randf())

func _apply_dim():
	var x = l*dim
	var y = l
	sprite.region_rect = Rect2(0,0,x,y)
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.extents = Vector2(x,y)/2
	collision_shape.one_way_collision = true

func set_dim(_dim:int)->void:
	dim = _dim	
	_apply_dim()

func set_horizontal():
	$AnimationPlayer.current_animation = "Horizontal"
