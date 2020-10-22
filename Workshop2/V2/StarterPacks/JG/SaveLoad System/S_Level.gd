extends GameSavable
class_name S_Level

"""
Only One Per Level
saves, the current level to the file
"""

const id = "Level In Save File"
const curr_scene_name = "Current Level Name"
const curr_scene_file = "Current Level File Path"

func capture_state()->Dictionary:
	var state = {
		curr_scene_name : str(get_tree().current_scene.name),
		curr_scene_file : get_tree().current_scene.get_filename()
	}
	return state

func restore_state(state:Dictionary):
	
	pass

func get_id()->String:
	return id

static func get_level(from_data:Dictionary):
	if not from_data.has(id):
		return null
	
	var level_saver = from_data[id]
	var level_path = level_saver[curr_scene_file]
	var level_name = level_saver[curr_scene_name]
	return {"level_path":level_path,"level_name":level_name}
