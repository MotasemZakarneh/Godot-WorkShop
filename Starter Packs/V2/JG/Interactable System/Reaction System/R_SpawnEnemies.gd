extends Reaction
class_name R_SpawnEnemies

export var enemies_group = "E1"
export var min_time_between_enemies = 0.5
export var max_time_between_enemies = 2

func _react():
	var enemies = get_tree().get_nodes_in_group(enemies_group)
	
	for e in enemies:
		
		var c = Extentions.get_child_of_type(e,[SceneActivator])
		if c == null:
			continue
		
		var cc : SceneActivator = c
		cc.set_activity(true)
		
		var time = rand_range(min_time_between_enemies,max_time_between_enemies)
		yield(get_tree().create_timer(time),"timeout")
	
	_complete_reaction()
	pass
