extends ReactionSystem
class_name ReactionCollection

export (bool) var auto_start = false

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
	pass
