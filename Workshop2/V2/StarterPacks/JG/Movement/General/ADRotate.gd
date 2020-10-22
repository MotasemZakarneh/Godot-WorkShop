extends MoveSystem
class_name ADRotate

export var right_map = "ui_right"
export var left_map = "ui_left"
export var speed = 160

var body = null
var input = 0

func _ready():
	body = get_parent()
	pass

func _move_update(delta):
	_set_move_input()
	pass

func _move_fixed_update(delta):
	body.rotate(input*deg2rad(speed)*delta)
	pass

func _set_move_input():
	input = 0
	if Input.is_action_pressed(right_map):
		input += 1
	if Input.is_action_pressed(left_map):
		input -= 1
	pass

func _on_locked():
	input = 0
	pass
