extends SimpleComponent
class_name SimpleTrigger

"""
Must be parented to an Area2D to work,
and have the signals called appropriately
"""

signal on_enter(node)
signal on_exit(node)
signal on_area_enter(area)
signal on_area_exit(area)
signal on_body_enter(body)
signal on_body_exit(body)

export var max_interactions = -1
export var time_between_interactions = 0.5
export var connect_body = true
export (Array,String) var interaction_groups = ["Player"]

var enters_count = 0
var exits_count = 0
var enters_time_counter = 0
var exits_time_counter = 0

var body : Area2D

func _ready():
	body = get_parent()
	
	var _e = body.connect("area_entered",self,"_on_entered")
	_e = body.connect("area_exited",self,"_on_exitted")
	
	if connect_body:
		_e = body.connect("body_entered",self,"_on_entered")
		_e = body.connect("body_exited",self,"_on_exitted")
	pass

func _process(delta):
	if exits_time_counter>=0:
		if time_between_interactions>0:
			exits_time_counter = exits_time_counter - delta/time_between_interactions
		else:
			exits_time_counter = 0
	
	if enters_time_counter>=0:
		if time_between_interactions>0:
			enters_time_counter = enters_time_counter - delta/time_between_interactions
		else:
			enters_time_counter = 0
	pass

func _on_entered(node : Node2D):
	if not Extentions.test_groups_on_node(node,interaction_groups):
		return
	if not test_enters_count():
		return
	if is_entering():
		return
	
	enters_time_counter = 1
	emit_signal("on_enter",node)
	
	if node is Area2D:
		emit_signal("on_area_enter",node)
	elif not node is Area2D and connect_body:
		emit_signal("on_body_enter",node)
	pass

func _on_exitted(node : Node2D):
	if not Extentions.test_groups_on_node(node,interaction_groups):
		return
	if not test_exits_count():
		return
	if is_exitting():
		return
	
	exits_time_counter = 1
	emit_signal("on_exit",node)
	if node is Area2D:
		emit_signal("on_area_exit",node)
	elif not node is Area2D and connect_body:
		emit_signal("on_body_exit",node)
	pass

func test_enters_count():
	if max_interactions<0:
		return true
	
	return enters_count < max_interactions

func test_exits_count():
	if max_interactions<0:
		return true
	
	return exits_count < max_interactions

func is_entering():
	return enters_time_counter > 0

func is_exitting():
	return exits_time_counter > 0
