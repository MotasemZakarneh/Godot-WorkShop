extends Node
class_name Extentions

static func get_children_in_group(group:String,node:Node)->Array:
	var children = node.get_children()
	var filtered_children = []
	
	for c in children:
		if c.is_in_group(group):
			filtered_children.append(c)
	
	return filtered_children

static func get_children_in_group_recursively(group,node:Node)->Array:
	var children_in_group = []
	
	var all_children = []
	get_children_recursively(node,all_children)
	
	for c in all_children:
		if c.is_in_group(group):
			children_in_group.append(c)
	
	return children_in_group

static func get_children_recursively(node:Node,recursive_children_holder:Array):
	if node.get_child_count()==0:
		return
	
	var node_children = node.get_children()
	
	for node_child in node_children:
		if not recursive_children_holder.has(node_child):
			recursive_children_holder.append(node_child)
			get_children_recursively(node_child,recursive_children_holder)
	
	pass

static func get_child_of_type(node:Node,types : Array):
	var children = []
	get_children_recursively(node,children)
	
	for type in types:
		for c in children:
			if c is type:
				return c
	
	return null

static func get_children_of_type(node:Node,types : Array):
	var children = []
	get_children_recursively(node,children)
	
	var filtered = []
	for type in types:
		for c in children:
			if c is type:
				if not filtered.has(c):
					filtered.append(c)
	
	return filtered

static func test_groups_on_node(node,groups):
	for g in groups:
		if node.is_in_group(g):
			return true
	return false
