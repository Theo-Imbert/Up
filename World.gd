extends Node2D

#var vitesse_laser := 0

onready var player = $Player
onready var portal1 = $Portal1

const l = 8

var button_activated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	move_portal1($Portal1.position)
	move_portal2($Portal2.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_button_activation()

#func _physics_process(delta):
#	kill_laser(delta)


func check_button_activation():
	var new_button_activation = false
	for button in get_tree().get_nodes_in_group("Button"):
		if button.activated:
			new_button_activation = true
			break
	
	if new_button_activation != button_activated:
		button_activated = new_button_activation
		if button_activated:
			$TileMap.activate_platform()
		else:
			$TileMap.reset_platform()

#func kill_laser(delta):
#	$Laser.position.y -= vitesse_laser*delta
#
#	#need to be in group laser_kill
#	for node in get_tree().get_nodes_in_group("laser_kill"):
#		if node.position.y > $Laser.position.y:
#			node.queue_free()
#
#	for node in get_tree().get_nodes_in_group("laser_restart"):
#		if node.position.y > $Laser.position.y:
#			get_tree().reload_current_scene()


# PORTALf

var disable_1 = false
var disable_2 = false

func move_portal1(new_position:Vector2):
	try_move_portal($Portal1,new_position)

func move_portal2(new_position:Vector2):
	try_move_portal($Portal2,new_position)

func try_move_portal(portal:Node2D,new_position:Vector2)->bool:
	var new_tile = Vector2(int(new_position.x/l),int(new_position.y/l))
	if $TileMap.get_cellv(new_tile) != -1 and $TileMap.get_collision_layer_bit($TileMap.get_cellv(new_tile)):
		return false
	portal.position = Vector2(int(new_position.x/l)*l,int(new_position.y/l)*l)
	return true

func _on_Portal1_body_entered(body):
	if not(disable_1):
		disable_2 = true
		body.position = $Portal2.position

func _on_Portal1_body_exited(body):
	disable_1 = false

func _on_Portal2_body_entered(body):
	if not(disable_2):
		disable_1=true
		body.position = $Portal1.position

func _on_Portal2_body_exited(body):
	disable_2 = false

func _on_Restart_pressed():
	restart()

func restart():
	get_tree().reload_current_scene()
