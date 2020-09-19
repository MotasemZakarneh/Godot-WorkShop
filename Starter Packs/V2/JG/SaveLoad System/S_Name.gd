extends GameSavable
class_name S_Name

export (NodePath) var node_to_save

func capture_state()->Dictionary:
	var d = {
		"Node Name":get_node(node_to_save).name
	}
	return d

func restore_state(state : Dictionary):
	get_node(node_to_save).name = state["Node Name"]
	pass