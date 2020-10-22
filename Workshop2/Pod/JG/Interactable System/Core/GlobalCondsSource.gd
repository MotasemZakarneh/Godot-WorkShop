extends InteractionSystem
class_name GlobalCondsSource

"""
Recommended only one per scene.
if there are Interactables, that use GlobalConditions.
then, the scene of this node, must be added.
"""

export (String,FILE,"*.json") var global_conds_path
var global_conds = {}
const global_conds_group = "Global Conditions"

func _ready():
	if not is_in_group(global_conds_group):
		add_to_group(global_conds_group)
	
	if global_conds.size() != 0:
		return
	
	var file = File.new()
	
	var er = file.open(global_conds_path,File.READ)
	if er != OK:
		print("Can Not find Level Conditions Source at Path " + str(global_conds_path))
		return
	var json_text = file.get_as_text()
	file.close()
	
	global_conds = parse_json(json_text) 
	pass

func update_condition(key,to):
	if not global_conds.has(key):
		return
	global_conds[key] = to
	pass
