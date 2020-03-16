extends Area2D

const SPEED_ROTATION = 180
const SPEED_MOVE = 250
const SPEED_ACCELERATION = 0.007
const SPEED_DECELERATION = 0.0

var motion = Vector2(0,0)
var size_screen
var buffer_screen : int = 8


func _ready():
	size_screen = get_viewport_rect().size


func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation_degrees -= SPEED_ROTATION * delta
	if Input.is_action_pressed("ui_right"):
		rotation_degrees += SPEED_ROTATION * delta
	var direction_movement_forward = Vector2(1,0).rotated(rotation)
	var direction_movement_backward = Vector2(-1,0).rotated(rotation)
	
	if Input.is_action_pressed("ui_up"):
		motion = motion.linear_interpolate(direction_movement_forward, SPEED_ACCELERATION)
	if Input.is_action_pressed("ui_down"):
		motion = motion.linear_interpolate(direction_movement_backward, SPEED_ACCELERATION)
	else:
		motion = motion.linear_interpolate(Vector2(0,0), SPEED_DECELERATION)
	
	position += motion * SPEED_MOVE * delta
	position.x = wrapf(position.x, -buffer_screen, size_screen.x + buffer_screen)
	position.y = wrapf(position.y, -buffer_screen, size_screen.y + buffer_screen) 
