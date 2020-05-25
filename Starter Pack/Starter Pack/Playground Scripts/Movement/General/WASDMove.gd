extends WSForward
class_name WASDMove

export var right_map = "ui_right"
export var left_map = "ui_left"

func _set_vel(delta):
	._set_vel(delta)
	vel.x =lerp(vel.x,target_vel.x,accel*delta)
	pass

func _set_move_input():
	._set_move_input()
	input.x = 0
	
	if Input.is_action_pressed(right_map):
		input.x += 1
	if Input.is_action_pressed(left_map):
		input.x -= 1
	
	pass
