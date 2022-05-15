extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var going_position:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	going


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Tween.interpolate_property(self, "position",start_pos, new_going_pos, moving_time/2,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
