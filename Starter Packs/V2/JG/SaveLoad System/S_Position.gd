extends GameSavable
class_name S_Position

export (NodePath) var node_to_save

func capture_state()->Dictionary:
	var node = get_node(node_to_save)
	var pos = {"x" : node.position.x,
		"y" : node.position.y
	}
	return pos

func restore_state(state:Dictionary):
	var node = get_node(node_to_save)
	node.position = Vector2(state["x"],state["y"])
	pass
