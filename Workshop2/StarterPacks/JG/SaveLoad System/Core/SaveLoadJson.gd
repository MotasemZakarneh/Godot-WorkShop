extends SaveLoadSystem
class_name SaveLoadJson

"""
ToUse Add SaveLoadJson.tscn To AutoLoad
For Levels to get saved, the base of the level must be in gorup 'Level'
"""

const saves_dir = "user://Game Save/"
const extention = ".json"

func _process(delta):
	if Input.is_action_just_released("save"):
		capture_state("Test")
	elif Input.is_action_just_released("load"):
		restore_state("Test")
	pass

func capture_state(to_file):
	var savables = get_tree().get_nodes_in_group(GameSavable.save_group)
	var state = { }
	
	for s in savables:
		var node_state = s.capture_state()
		state[s.get_id()] = node_state
	
	_write_file(to_file,state)
	pass

func restore_state(from_file):
	var saved_data : Dictionary = _read_file(from_file)
	$DataDistributor.send_data(saved_data)
	pass

func _read_file(file_name)->Dictionary:
	var data = {}
	
	var file = File.new()
	var file_path = saves_dir.plus_file(file_name+extention)
	if not file.file_exists(file_path):
		return data
	
	file.open(file_path,File.READ)
	var json_text = file.get_as_text()
	file.close()
	return parse_json(json_text)

func _write_file(file_name,data:Dictionary):
	var file_path : String = saves_dir.plus_file(file_name+extention)
	
	var dir = Directory.new()
	if not dir.file_exists(file_path):
		dir.make_dir_recursive(file_path.get_base_dir())
	
	var file = File.new()
	file.open(file_path,File.WRITE)
	var json_text = JSON.print(data,"\t")
	file.store_string(json_text)
	file.close()
	pass
