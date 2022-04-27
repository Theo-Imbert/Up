extends Node2D


var pos_last_platform := Vector2(0,-50)
var render_distance := 80
var next_platform_distance := 60
var angle_random = PI/2
var distance_random := 0.3

var vitesse_laser := 0

var PLATFORM := preload("res://Platform.tscn") 

onready var player = $Player
onready var portal1 = $Portal1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	random_platform_generation()

func _physics_process(delta):
	kill_laser(delta)
	

func kill_laser(delta):
	$Laser.position.y -= vitesse_laser*delta
	
	#need to be in group laser_kill
	for node in get_tree().get_nodes_in_group("laser_kill"):
		if node.position.y > $Laser.position.y:
			node.queue_free()
	
	

func random_platform_generation():
	#si au dessus d'un seuil generer platforme pour l'instant on en genère une
	if player.position.y-pos_last_platform.y < render_distance:
		generate_next_platform()

func generate_next_platform():
	# utilise pos last platform pour générer la suivante
	var new_position = rand_range(1-distance_random,1+distance_random)*next_platform_distance * Vector2(0,-1).rotated(rand_range(-angle_random,angle_random)) + pos_last_platform
	create_platform(new_position,randi()%5+3)
	pos_last_platform = new_position

func create_platform(pos:Vector2,dim:int):
	var platform = PLATFORM.instance()
	add_child(platform)
	platform.instantiate(pos,dim)

# PORTAL

var disable_1 = false
var disable_2 = false

func move_portal1(new_position:Vector2):
	$Portal1.position = new_position

func move_portal2(new_position:Vector2):
	$Portal2.position = new_position

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
