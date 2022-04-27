extends Position2D


var dim = 5
var l = 8

onready var sprite = $KinematicBody2D/Sprite
onready var collision_shape = $KinematicBody2D/CollisionShape2D

func _apply_dim():
	var x = l*dim
	var y = l
	sprite.region_rect = Rect2(0,0,x,y)
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.extents = Vector2(x,y)/2
	collision_shape.one_way_collision = true

func instantiate(_position:Vector2,_dim:int)->void:
	
	dim = _dim
	position = _position
	
	_apply_dim()
