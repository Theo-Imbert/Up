extends KinematicBody2D


onready var ground_detection = $Position2D/Ground_detection
onready var wall_detection = $Position2D/Wall_detection
#This is a test
var going_dir = Vector2.RIGHT

const WALK_FORCE = 700
const WALK_MAX_SPEED = 40
const STOP_FORCE = 1300
const MASS = 8

var velocity := Vector2(0,0)


onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _physics_process(delta):
	
	if is_on_floor():
		manage_going_dir()
	
	var walk = WALK_FORCE * going_dir.x
	
	if abs(walk) < WALK_FORCE * 0.2:
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += walk * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	# Vertical movement code. Apply gravity.
	velocity.y += gravity * delta * MASS
	
	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

func manage_going_dir():
	if facing_wall() or not(facing_ground()):
		change_going_dir()

func change_going_dir():
	if going_dir == Vector2.RIGHT:
		going_dir = Vector2.LEFT
	else:
		going_dir = Vector2.RIGHT
	manage_facing_dir()

func manage_facing_dir():
	if going_dir == Vector2.RIGHT:
		$AnimatedSprite.flip_h = false
		$Position2D.position = Vector2.ZERO
	else:
		$AnimatedSprite.flip_h = true
		$Position2D.position = Vector2(-9,0)

func facing_wall()->bool:
	if wall_detection.get_overlapping_bodies().size() == 0:
		return false
	return true

func facing_ground()->bool:
	if ground_detection.get_overlapping_bodies().size() == 0:
		print("false")
		return false
	return true
