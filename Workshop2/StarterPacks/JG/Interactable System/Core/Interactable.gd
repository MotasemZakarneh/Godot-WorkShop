extends InteractionSystem
class_name Interactable

"""
Base node, that acts as interactable, must contain, InteractableCollections in order to work.
Must Be Parented To An Area2D, or 'interact' function must be called externally
"""

signal on_interactable_started
signal on_interactable_finished
const interactable_group = "Interactable"

export var max_plays_count = -1

var plays_count = 0

func _ready():
	if not is_in_group(interactable_group):
		add_to_group(interactable_group)
	pass

func interact_n(_node):
	interact()
	pass

func interact():
	if not is_good_plays_count():
		return
	
	plays_count = plays_count + 1
	
	var collections = Extentions.get_children_in_group(InteractableCollection.interactable_col_group,self)
	for c in collections:
		var satisfied = c.is_satisfied()
		if satisfied:
			_on_interactable_started()
			emit_signal("on_interactable_started")
			if c.can_interact():
				c.interact()
				yield(c,"on_collection_finished")
			else:
				yield(c,"on_collection_failed")
			
			yield(get_tree(),"idle_frame")
			_on_interactable_finished()
			emit_signal("on_interactable_finished")
			return
	
	yield(get_tree(),"idle_frame")
	_on_interactable_finished()
	emit_signal("on_interactable_finished")
	pass

func _on_interactable_started():
	pass
func _on_interactable_finished():
	pass

func is_good_plays_count():
	if max_plays_count == -1:
		return true
	return plays_count < max_plays_count
