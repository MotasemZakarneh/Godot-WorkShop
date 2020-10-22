extends Node2D

func _process(delta):
	if Input.is_action_just_released("ui_right"):
		var v = rand_range(-100,100)
		$SimpleSaver.set_var("Something",v)
		print("Writing " + str(v))
	elif Input.is_action_just_released("ui_left"):
		print("Reading " + str($SimpleSaver.get_var("Something")))
	pass

