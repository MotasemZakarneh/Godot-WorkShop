extends Reaction
class_name R_SetVisibility

export var state = true
export (NodePath) var node
export var nodes_group = ""

#To Be Overridden
func _react():
	if has_node(node):
		get_node(node).visible = state
	
	if nodes_group!="":
		var nodes = get_tree().get_nodes_in_group(nodes_group)
		for n in nodes:
			n.visible = state
	
	_complete_reaction()
	pass
