extends Reaction

export (PackedScene) var spawnable : PackedScene

export var pos_group = ""
export var match_pos_group = true
export var parent_group = ""

var body = null

func _react():
	body = get_parent()
	
	var spawn_node = null
	var spawn_pos = body.global_position
	var spawn_rot = body.global_rotation
	
	if pos_group != "":
		var pos_n = get_tree().get_nodes_in_group(pos_group)[0]
		spawn_pos = pos_n.global_position
		spawn_rot = pos_n.global_rotation
	
	var spawned = spawnable.instance()
	spawned.global_position = spawn_pos
	spawned.global_rotation = spawn_rot
	
	if parent_group != "":
		var parent_n : Node = get_tree().get_nodes_in_group(parent_group)[0]
		parent_n.add_child(spawned)
	else:
		get_tree().current_scene.add_child(spawned)
	
	_complete_reaction()
	pass
