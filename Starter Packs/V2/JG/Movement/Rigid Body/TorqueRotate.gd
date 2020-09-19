extends RigidMove
class_name TorqueRotate

export var max_turn_speed = 1000
export var turn_strength = 20
export var slowing_strength = 20
export var turn_right_map = "ui_right"
export var turn_left_map = "ui_left"

var dir = 0
var body : RigidBody2D

func _ready():
	body = get_parent()
	pass

func _move_update(delta):
	_set_dir()
	pass

func _move_fixed_update(delta):
	var torque = dir*turn_strength
	if dir == 0:
		torque = -sign(body.angular_velocity)*slowing_strength
	
	body.angular_velocity = body.angular_velocity + torque * delta
	
	if abs(body.angular_velocity) > max_turn_speed:
		body.angular_velocity = sign(body.angular_velocity) * max_turn_speed
	
	if is_zero_approx(body.angular_velocity):
		body.angular_velocity = 0
	pass

func _set_dir():
	dir = 0
	if Input.is_action_pressed(turn_right_map):
		dir += 1
	if Input.is_action_pressed(turn_left_map):
		dir += -1
	pass
