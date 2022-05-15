extends Sprite


#const small_portal_dist = 16
#const small_down_portal_dist = 16
#
const portal_dist = 16
#const down_portal_dist = 16

const l = 8

var going_position : Vector2

func _process(delta):
	
	var dir = get_parent().last_key_pressed
	set_position(dir*portal_dist)
	
	if Input.is_action_pressed("ui_portal1") or Input.is_action_pressed("ui_portal2"):
		visible = true
	else:
		visible = false
	
	
#	var dir = get_parent().last_key_pressed
#
#	if get_parent().velocity.length() < 10:
#		if dir != Vector2.DOWN:
#			position = dir * small_portal_dist
#		else:
#			position = dir * small_down_portal_dist
#	else:
#		if dir != Vector2.DOWN:
#			position = dir * portal_dist
#		else:
#			position = dir * down_portal_dist

func set_position(new_position:Vector2):
	new_position = get_parent().position + new_position
	position =  Vector2(int(new_position.x/l)*l,int(new_position.y/l)*l) - get_parent().position
