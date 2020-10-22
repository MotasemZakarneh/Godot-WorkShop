extends GameSavable
class_name S_InstConds

"""
Saver of, instance based conditions, must be childed to InstanceCondsSource
"""

const inst_conds_key = "Instance Conditions"

func capture_state() -> Dictionary:
	var state = {
		inst_conds_key:get_parent().inst_conds
		}
	return state

func restore_state(state:Dictionary):
	get_parent().inst_conds = state[inst_conds_key]