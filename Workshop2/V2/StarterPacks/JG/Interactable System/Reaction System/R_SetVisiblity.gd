extends Reaction
class_name R_SetVisibility

export var state = true
export (NodePath) var node

#To Be Overridden
func _react():
	get_node(node).visible = state
	_complete_reaction()
	pass
