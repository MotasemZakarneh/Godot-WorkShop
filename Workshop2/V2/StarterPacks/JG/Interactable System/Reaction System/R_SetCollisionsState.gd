extends Reaction
class_name R_SetCollisions_State

export var state = false
export (Array,NodePath) var nodes_paths

var collision_nodes = []

func _react():
	_special_init()
	for n in collision_nodes:
		n.disabled = !state
	_complete_reaction()
	pass

func _special_init():
	for path in nodes_paths:
		var node = get_node(path)
		var all_children = []
		Extentions.get_children_recursively(node,all_children)
		
		var children = node.get_children()
		for c in children:
			process_node(c)
	pass

func process_node(node):
	if node is CollisionPolygon2D or node is CollisionShape2D:
		if not collision_nodes.has(node):
			collision_nodes.append(node)
	pass
