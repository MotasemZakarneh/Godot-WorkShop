extends GameSavable
class_name S_CollisionState

export (NodePath) var node_path
const activity_key = "Collision Activty"

func capture_state()->Dictionary:
	var collision_node = get_node(node_path)
	var state = {
		activity_key : !collision_node.disabled
	}
	return state

func restore_state(state:Dictionary):
	var collision_node = get_node(node_path)
	collision_node.disabled = !state[activity_key]
	pass