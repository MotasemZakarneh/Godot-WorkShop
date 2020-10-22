extends JG
class_name MoveSystem

var is_locked = false 

func set_lock(to_state):
	is_locked = to_state
	if is_locked:
		_on_locked()
	pass

func _process(delta):
	if is_locked:
		return
	_move_update(delta)
	pass

func _physics_process(delta):
	if is_locked:
		return
	_move_fixed_update(delta)
	pass

#override these functions to create movement
func _move_update(_delta):
	
	pass

func _move_fixed_update(_delta):
	
	pass

func _on_locked():
	
	pass
