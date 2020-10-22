extends State

export var color_val = Color.blue

#override these to get behavior inside of your state

func on_enter():
	machine.get_unit().change_color(color_val)
	pass

func on_process(delta):
	if Input.is_action_just_released("ui_down"):
		machine.transition_to_state_n("Green")
		print("Transitioning To Green State")
	if Input.is_action_just_released("ui_up"):
		print("We are at the final state, can not transition more")
	pass

func on_physics_process(delta):
	
	pass

func on_exit():
	
	pass
