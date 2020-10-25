extends CanvasLayer

func _ready():
	get_node("Win").visible = false
	get_node("Lose").visible = false
	pass

func call_win():
	get_node("Win").visible = true
	get_node("LossTimer").stop()
	get_node("RestartTimer").start()
	pass

func call_lose():
	get_node("Lose").visible = true
	get_node("RestartTimer").start()
	var win_field = get_tree().get_nodes_in_group("WinField")[0]
	Extentions.set_collision_state(win_field,false)
	pass

func _process(_delta):
	var remaining_time = get_node("LossTimer").time_left
	remaining_time = floor(remaining_time)
	remaining_time = str(remaining_time)
	get_node("TimerLabel").text = "Time : " + remaining_time
	pass

func _on_LossTimer_timeout():
	call_lose()
	pass

func _on_RestartTimer_timeout():
	var _er = get_tree().reload_current_scene()
	pass

func _on_WinTrigger_on_body_enter(_body):
	call_win()
	pass
