extends Reaction
class_name R_Kill

export (NodePath) var path_to_kill
export var group_to_kill = ""

func _react():
	if has_node(path_to_kill):
		get_node(path_to_kill).queue_free()
	
	yield(get_tree(),"idle_frame")
	if group_to_kill != "":
		var nodes = get_tree().get_nodes_in_group(group_to_kill)
		for n in nodes:
			n.queue_free()
	
	yield(get_tree(),"idle_frame")
	_complete_reaction()
	pass
