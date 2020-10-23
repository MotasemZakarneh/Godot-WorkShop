extends Reaction
class_name R_MoveNode

export (NodePath) var node
export (NodePath) var target_point

func _react():
	get_node(node).global_position = get_node(target_point).global_position
	_complete_reaction()
	pass
