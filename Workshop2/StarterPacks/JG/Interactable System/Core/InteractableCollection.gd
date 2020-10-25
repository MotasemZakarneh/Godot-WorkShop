extends InteractionSystem
class_name InteractableCollection

"""
Holds, Conditionals as fields.
if, conditions succeed, Reactions get played
Reactions must be childed to this node
Reactions, are actions that happen, and effect the game, they are simple scripts that
do one thing

'inst_src_conds_path' is only used when 'use_global_source' is disabled
'inst_src_conds_path' must point to a node that has 'InstanceCondsSource script'
"""

signal on_collection_finished
signal on_collection_failed

export (bool) var use_global_source = true
export (NodePath) var inst_src_conds_path = ""
export(Extentions.decision_operator) var operation = Extentions.decision_operator.AND

export (Array,String) var test_keys
export (Array,bool) var test_states

const interactable_col_group = "Interactable Collection"
var test_conds = []
var reactions = []

func _ready():
	if test_keys.size()>test_states.size():
		print("Filling, interactable collection keys without state as 'False'")
	elif test_keys.size()<test_states.size():
		print("Ignoring Extra interactable collection, States, only keys were created")
	
	if not is_in_group(interactable_col_group):
		add_to_group(interactable_col_group)
	
	test_conds = _make_test_conds(test_keys,test_states)
	reactions = Extentions.get_children_in_group_recursively(Reaction.reaction_group,self)
	pass

func is_satisfied()->bool:
	var results = []
	var conditions_src_table = _get_conds_src_table()
	
	for i in range(test_conds.size()):
		var inst : Condition = test_conds[i]
		
		var ori_state = conditions_src_table[inst.description]
		var ori : Condition = Condition.new(inst.description,ori_state)
		results.append( inst.compare_c(ori) )
	
	return Extentions.check_decision_operation(operation,results)

func can_interact()->bool:
	return true

func interact():
	if not can_interact():
		emit_signal("on_collection_failed")
		return
	for r in reactions:
		var re : Reaction = r
		re.react()
		yield(re,"on_completed")
	emit_signal("on_collection_finished")
	pass

func _make_test_conds(keys:Array,states:Array) -> Array:
	var temp_test_conds = []
	for i in range(keys.size()):
		var key = keys[i]
		var state = false
		if i<=states.size()-1:
			state = states[i]
		var c = Condition.new(key,state)
		temp_test_conds.append(c)
	return temp_test_conds

func _get_conds_src_table():
	if use_global_source:
		return get_tree().get_nodes_in_group(GlobalCondsSource.global_conds_group)[0].global_conds
	
	return get_node(inst_src_conds_path).inst_conds
