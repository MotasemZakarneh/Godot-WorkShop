extends MoveSystem
class_name WSForward

export var up_map = "ui_up"
export var down_map = "ui_down"

export var speed = 300
export var accel = 100
export var face_move_dir = true

var input = Vector2()
var last_non_zero_input = Vector2()
var target_vel = Vector2()
var vel = Vector2()
var mover : Mover
var body : KinematicBody2D

func _ready():
	body = get_parent()
	mover = Mover.new()
	mover.set_up(body)
	pass

func _process(_delta):
	_set_move_input()
	_set_last_non_zero_input()
	pass

func _physics_process(delta):
	target_vel = input.normalized() * speed
	_set_vel(delta)
	vel = mover.move(vel,delta)
	
	if face_move_dir:
		body.rotation = last_non_zero_input.angle()
	pass

func _set_vel(delta):
	vel.y =lerp(vel.y,target_vel.y,accel*delta)
	pass

func _set_move_input():
	input.y = 0
	
	if Input.is_action_pressed(up_map):
		input.y -= 1
	if Input.is_action_pressed(down_map):
		input.y += 1
	pass

func _set_last_non_zero_input():
	if input != Vector2.ZERO:
		last_non_zero_input = input
	pass
