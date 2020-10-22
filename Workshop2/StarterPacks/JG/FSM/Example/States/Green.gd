extends State

export var color_val = Color.green

#override these to get behavior inside of your state

func on_enter():
	machine.get_unit().change_color(color_val)
	pass

func on_process(delta):
	if Input.is_action_just_released("ui_down"):
		machine.transition_to_state_n("Red")
		print("Transitioning To Red State")
	if Input.is_action_just_released("ui_up"):
		machine.transition_to_state_n("Blue")
		print("Transitioning To Blue State")
	pass

func on_physics_process(delta):
	
	pass

func on_exit():
	
	pass
