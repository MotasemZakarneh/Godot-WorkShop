extends PlayGround
class_name SceneActivator

var body
export var start_activity = false

func _ready():
	body = get_parent()
	set_activity(start_activity)
	pass

func set_activity(state):
	var bn : Node2D = body
	bn.visible = state
	
	bn.set_process(state)
	bn.set_physics_process(state)
	bn.set_process_input(state)
	bn.set_process_internal(state)
	bn.set_process_unhandled_input(state)
	bn.set_process_unhandled_key_input(state)
	
	var types = [CollisionShape2D,CollisionPolygon2D]
	var children = Extentions.get_children_of_type(bn,types)
	for c in children:
		c.disabled = !state
	pass
