extends InteractionSystem
class_name InstanceCondsSource

"""
Instance based conds source, doesn't have to be stored inside of a json file
"""

const inst_conds_group = "Instance Conditions"
var inst_conds = {}
export (Array,String) var src_keys
export (Array,bool) var src_states

"""
Conditions Source, based on instance
"""

func _ready():
	if not is_in_group(inst_conds_group):
		add_to_group(inst_conds_group)
	
	if src_keys.size()>src_states.size():
		print("Filling, src_keys of InstanceCondsSource without state as 'False'")
	elif src_keys.size()<src_states.size():
		print("Ignoring Extra Condition of InstanceCondsSource, src_states, only src_keys were created")
	
	for i in range(0,src_keys.size()):
		var key = src_keys[i]
		var state = false
		if i <= src_states.size()-1:
			state = src_states[i]
		inst_conds[key] = state
	pass

func update_condition(key,to):
	if not inst_conds.has(key):
		return
	inst_conds[key] = to
	pass
