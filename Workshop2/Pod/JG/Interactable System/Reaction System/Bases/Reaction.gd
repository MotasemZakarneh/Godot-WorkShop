extends ReactionSystem
class_name Reaction
export var reaction_delay = 0.0
export var reaction_duration = 0.0

signal on_completed
const reaction_group = "Reaction"
var is_done = false

func _ready():
	if not is_in_group(reaction_group):
		add_to_group(reaction_group)
	pass

func react():
	is_done = false
	yield (get_tree(),"idle_frame")
	
	if reaction_delay>0:
		yield(get_tree().create_timer(reaction_delay),"timeout")
	
	_react()
	
	while not is_done:
		yield (get_tree(),"idle_frame")
	
	if reaction_duration>0:
		yield (get_tree().create_timer(reaction_duration),"timeout")
	
	emit_signal("on_completed")
	pass

func _complete_reaction():
	is_done = true
	pass

#override this function in order to have special functionality for
#reactions, and the "is_done" must be set to true at the end
func _react():
	_complete_reaction()
	pass
