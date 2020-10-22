extends RigidMove
class_name PushMove
enum PushAxis {Up,Right}

export (PushAxis) var push_axis = PushAxis.Up
export var push_strength = 70
export var slowing_strength = 70

export var max_speed = 500
export var push_map = "ui_up"
export var is_relative_vel = false

var dir = Vector2()
var body : RigidBody2D

func _ready():
	body = get_parent()
	body.gravity_scale = 0
	pass

func _move_update(delta):
	_set_dir()
	pass

func _move_fixed_update(delta):
	var force = dir*push_strength
	
	if dir == Vector2.ZERO:
		force = -body.linear_velocity.normalized()*slowing_strength
	
	body.linear_velocity = body.linear_velocity + force * delta
	
	if is_relative_vel:
		body.linear_velocity = _get_fwd() * body.linear_velocity.length()
	
	if is_zero_approx(body.linear_velocity.length()):
		body.linear_velocity = Vector2.ZERO
	
	if body.linear_velocity.length()>=max_speed:
		body.linear_velocity = body.linear_velocity.clamped(max_speed)
	pass

func _on_is_locked():
	dir = Vector2.ZERO
	pass

func _set_dir():
	dir = Vector2()
	
	if Input.is_action_pressed(push_map):
		dir += _get_fwd()
	
	pass

func _get_fwd():
	var fwd = Vector2()
	match push_axis:
		PushAxis.Up:
			fwd = -body.transform.y
		PushAxis.Right:
			fwd = body.transform.x
	return fwd
