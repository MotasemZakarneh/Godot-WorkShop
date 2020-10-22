extends Reaction
class_name R_UpdateCondition

"""
Updates in the condition in the source
inst_conds_src_path is only used when use_global is false
"""

export var key = "condition_key"
export var to_state = true
export(bool) var use_global = true
export (NodePath) var inst_conds_src_path = ""

var conds_source = null

func _react():
	conds_source.update_condition(key,to_state)
	emit_signal("behavior_completed")
	pass

func _special_init():
	
	if use_global:
		conds_source = get_tree().get_nodes_in_group(GlobalCondsSource.global_conds_group)[0]
	else:
		conds_source = get_node(inst_conds_src_path)
	
	pass
