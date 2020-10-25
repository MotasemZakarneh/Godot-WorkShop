extends ReactionSystem
class_name ReactionCollection

export (bool) var auto_start = false
export (NodePath) var obj_to_destroy_after_done

func _ready():
	if auto_start:
		react()
	pass

func react():
	for c in get_children():
		var cn : Reaction = c
		if not cn.is_in_group(Reaction.reaction_group):
			continue
		cn.react()
		yield (cn,"on_completed")
	
	if has_node(obj_to_destroy_after_done):
		yield (get_tree(),"idle_frame")
		get_node(obj_to_destroy_after_done).queue_free()
	pass

func react_n(_caller,_helper_var):
	react()
	pass
