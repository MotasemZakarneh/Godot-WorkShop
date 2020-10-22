extends SaveLoadSystem

var is_sending_data = false
var is_loading = false
var target_level_name = ""

func send_data(file_data):
	if is_sending_data:
		return
	
	is_sending_data = true
	_level_data_distribution(file_data)
	pass

func distribute_data(data : Dictionary):
	var savables = get_tree().get_nodes_in_group(GameSavable.save_group)
	for s in savables:
		var id = s.get_id()
		if data.has(id):
			var savable_state = data[id]
			s.restore_state(savable_state)
	pass

func _level_data_distribution(data):
	var level = S_Level.get_level(data)
	target_level_name = level["level_name"]
	
	get_tree().connect("node_added",self,"_on_node_added")
	is_loading = true
	
	while(is_loading):
		yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	
	distribute_data(data)
	pass

func _on_node_added(node:Node):
	if node.is_in_group("Level") and node.name == target_level_name:
		get_tree().disconnect("node_added",self,"_on_node_added")
		is_loading = false
	pass
