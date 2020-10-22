extends MoveSystem
class_name WASDMove

enum MoveMode { WS,AD,WASD }
export (MoveMode) var move_mode = MoveMode.WS

export var up_map = "ui_up"
export var down_map = "ui_down"
export var right_map = "ui_right"
export var left_map = "ui_left"

export var speed = 300
export var accel = 800
export var face_move_dir = true
export var facing_to_entire_body = true
export var use_accel = true
export var saftey_input_threshold = 0.065

var input = Vector2()
var last_non_zero_input = Vector2()
var target_vel = Vector2()
var vel = Vector2()
var last_non_zero_input_safe = Vector2()
var saftey_counter = 0

var mover : Mover
var body : KinematicBody2D
var sprite

func _ready():
	body = get_parent()
	mover = Mover.new()
	mover.set_up(body)
	if facing_to_entire_body:
		sprite = body
	else:
		sprite = Extentions.get_visual_body(body)
	pass

func _move_update(_delta):
	_set_move_input()
	_set_last_non_zero_input(_delta)
	pass

func _move_fixed_update(delta):
	target_vel = input.normalized() * speed
	_set_vel(delta)
	vel = mover.move(vel,delta)
	
	if face_move_dir:
		sprite.rotation = last_non_zero_input_safe.angle()
	pass

func _on_is_locked():
	input = Vector2.ZERO
	vel = Vector2.ZERO
	pass

func _set_vel(delta):
	match move_mode:
		MoveMode.WS:
			_set_y_vel(delta)
		MoveMode.AD:
			_set_x_vel(delta)
		MoveMode.WASD:
			_set_y_vel(delta)
			_set_x_vel(delta)
	
	vel = Extentions.clamp_magnitude(vel,speed)
	pass

func _set_y_vel(delta):
	if use_accel:
		var diff = target_vel.y-vel.y
		if Extentions.is_zero(diff):
			return
		
		#var dir = sign(diff)
		#vel.y = vel.y + dir * accel * delta
		vel.y = move_toward(vel.y,target_vel.y,accel*delta)
		
		#vel.y =lerp(vel.y,target_vel.y,accel*delta)
	else:
		vel.y = target_vel.y
	pass

func _set_x_vel(delta):
	if use_accel:
		var diff = target_vel.x - vel.x
		if Extentions.is_zero(diff):
			return
		
		#var dir = sign(diff)
		#vel.x = vel.x + dir * accel*delta
		vel.x = move_toward(vel.x,target_vel.x,accel*delta)
		#vel.x =lerp(vel.x,target_vel.x,accel*delta)
	else:
		vel.x = target_vel.x
	pass

func _set_move_input():
	input.x = 0
	
	if Input.is_action_pressed(right_map):
		input.x += 1
	if Input.is_action_pressed(left_map):
		input.x -= 1
	
	input.y = 0
	
	if Input.is_action_pressed(up_map):
		input.y -= 1
	if Input.is_action_pressed(down_map):
		input.y += 1
	pass

func _set_last_non_zero_input(delta):
	if input != Vector2.ZERO:
		last_non_zero_input = input
		
		if last_non_zero_input_safe != last_non_zero_input:
			saftey_counter = saftey_counter + delta/saftey_input_threshold
		else:
			saftey_counter = 0
		if saftey_counter>=1:
			last_non_zero_input_safe = last_non_zero_input
			saftey_counter = 0
	pass
