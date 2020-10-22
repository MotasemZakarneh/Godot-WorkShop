extends State

export var color_val = Color.red

#override these to get behavior inside of your state

func on_enter():
	machine.get_unit().change_color(color_val)
	pass

func on_process(delta):
	if Input.is_action_just_released("ui_down"):
		print("We are at the first state, can not transition to that direction")
	if Input.is_action_just_released("ui_up"):
		machine.transition_to_state_n("Green")
		print("Transitioning To Green State")
	pass

func on_physics_process(delta):
	
	pass

func on_exit():
	
	pass
