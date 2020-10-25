extends Reaction
class_name R_SetCollisions_State

export var state = false
export (NodePath) var node_path
export (Array,NodePath) var nodes_paths
export var nodes_group = ""

var collision_nodes = []

func _react():
	_special_init()
	for n in collision_nodes:
		n.disabled = !state
	_complete_reaction()
	pass

func _special_init():
	for path in nodes_paths:
		process_node_and_children(path)
	process_node_and_children(node_path)
	if nodes_group != "":
		var nodes = get_tree().get_nodes_in_group(nodes_group)
		for n in nodes:
			process_node_and_children(n.get_path())
	pass

func process_node_and_children(path):
	if not has_node(path):
		#print(str(get_path()) + " :: pointing to a wrong path")
		return
	var n = get_node(path)
	var all_children = []
	Extentions.get_children_recursively(n,all_children)
	
	for c in all_children:
		process_node(c)
	pass

func process_node(node):
	if node is CollisionPolygon2D or node is CollisionShape2D:
		if not collision_nodes.has(node):
			collision_nodes.append(node)
	pass
