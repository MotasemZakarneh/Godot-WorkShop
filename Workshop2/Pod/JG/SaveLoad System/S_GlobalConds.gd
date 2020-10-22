extends GameSavable
class_name S_GlobalConds

"""
Only One Per Level
A Single GlobalConditionsSource (with group of 'Global Conditions') must exist in scene
"""

const global_conds_key = "Global Conditions"

func capture_state()->Dictionary:
	if _get_global_conds_source() == null:
		print("Trying to Save(Capture) GlobalCondsSource but no node exists")
		return {}
	
	var state = {
		global_conds_key : _get_global_conds_source().global_conds
	}
	return state

func restore_state(state : Dictionary):
	if _get_global_conds_source() == null:
		print("Trying to Load(Restore) GlobalCondsSource but no node exists")
		return
	
	var conds = state[global_conds_key]
	_get_global_conds_source().global_conds = conds 
	pass

func _get_global_conds_source():
	var sources = get_tree().get_nodes_in_group(GlobalCondsSource.global_conds_group)
	if sources.size() == 0:
		return null
	return sources[0]
