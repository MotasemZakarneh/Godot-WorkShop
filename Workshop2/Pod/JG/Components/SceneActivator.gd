extends SimpleComponent
class_name SceneActivator

var body
export var start_activity = true
export var use_recursive_in_start = true
export var include_visiblity = true

func _ready():
	body = get_parent()
	if not use_recursive_in_start:
		set_activity(start_activity)
	else:
		set_activity_recursive_to(start_activity)
	pass

func set_activity(state):
	var bn : Node2D = body
	
	_set_funcs_activity(bn,state)
	
	var types = [CollisionShape2D,CollisionPolygon2D]
	var children = Extentions.get_children_of_type(bn,types)
	for c in children:
		set_deferred("disabled",!state)
	pass

func set_activity_recursive_to(state):
	set_activity(state)
	
	var children = []
	Extentions.get_children_recursively(body,children)
	
	for c in children:
		_set_funcs_activity(c,state)
	pass

func _set_funcs_activity(to,state):
	if include_visiblity:
		to.visible = state
	
	to.set_process(state)
	to.set_physics_process(state)
	to.set_process_input(state)
	to.set_process_internal(state)
	to.set_process_unhandled_input(state)
	to.set_process_unhandled_key_input(state)
	pass
