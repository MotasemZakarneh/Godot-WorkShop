extends Reaction
class_name R_TurnOffCol

export (NodePath) var col

func _react():
	get_node(col).disabled = true
	_complete_reaction()
	pass
