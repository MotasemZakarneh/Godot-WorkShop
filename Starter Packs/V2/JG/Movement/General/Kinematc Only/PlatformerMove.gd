extends KinematicMove
class_name PlatformerMove

signal on_jumped
signal on_landed

var body : KinematicBody2D
enum JumpStyle{Continious,OnDown,OnUp}

export(JumpStyle) var jump_style = JumpStyle.Continious
export var jump_map = "ui_up"
export var jump_heigth = 100
export var gravity = 981
export var right_map = "ui_right"
export var left_map = "ui_left"
export var hori_speed = 200
export var hori_accel = 100

var vel = Vector2()
var hori_input = 0
var is_floating = false

func _ready():
	body = get_parent()
	pass

func _update_move(delta):
	_set_hori_input()
	pass

func _fixed_update_move(delta):
	_update_hori_vel(delta)
	body.move_and_slide(vel,Vector2.UP)
	if not _jump():
		_fall(delta)
	pass

func _on_locked():
	hori_input = 0
	pass

func _set_hori_input():
	hori_input = 0
	if Input.is_action_pressed(right_map):
		hori_input = hori_input + 1
	if Input.is_action_pressed(left_map):
		hori_input = hori_input - 1
	pass

func _jump():
	var jump_input = false
	match jump_style:
		JumpStyle.Continious:
			jump_input = Input.is_action_pressed(jump_map)
		JumpStyle.OnDown:
			jump_input = Input.is_action_just_pressed(jump_map)
		JumpStyle.OnUp:
			jump_input = Input.is_action_just_released(jump_map)
	var jumped = jump_input and body.is_on_floor()
	if jumped:
		jump_heigth = abs(jump_heigth)
		vel.y = sqrt(-2*gravity*-jump_heigth)*-1
		if not is_floating:
			is_floating = true
			emit_signal("on_jumped")
	return jumped

func _fall(delta):
	vel.y = vel.y + delta*gravity
	if body.is_on_floor():
		vel.y = gravity*delta
		if vel.y>0 and is_floating:
			emit_signal("on_landed")
			is_floating = false
	pass

func _update_hori_vel(delta):
	var max_speed = hori_input*hori_speed
	vel.x = lerp(vel.x,max_speed,hori_accel*delta)
	pass
