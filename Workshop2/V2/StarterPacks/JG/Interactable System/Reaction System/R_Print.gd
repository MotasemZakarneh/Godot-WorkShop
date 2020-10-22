extends Reaction
class_name R_Print

export (String) var message = "Message"

func _react():
	print(message)
	_complete_reaction()
	pass
