extends Sprite


const small_portal_dist = 15
const small_down_portal_dist = 0

const portal_dist = 70
const down_portal_dist = 10

func _process(delta):
	
	var dir = get_parent().last_key_pressed
	
	if get_parent().velocity.length() < 10:
		if dir != Vector2.DOWN:
			position = dir * small_portal_dist
		else:
			position = dir * small_down_portal_dist
	else:
		if dir != Vector2.DOWN:
			position = dir * portal_dist
		else:
			position = dir * down_portal_dist
	
