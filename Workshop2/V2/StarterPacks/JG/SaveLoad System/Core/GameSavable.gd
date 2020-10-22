extends SaveLoadSystem
class_name GameSavable
const save_group = "GameSavable"

func _ready():
	if not is_in_group(save_group):
		add_to_group(save_group)
	pass 

func capture_state() -> Dictionary:
	return {}

func restore_state(state:Dictionary):
	pass

func get_id()->String:
	return str(get_path())
