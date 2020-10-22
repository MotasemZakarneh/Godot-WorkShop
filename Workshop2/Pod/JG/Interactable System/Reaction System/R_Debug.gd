extends Reaction
class_name R_Debug

export (String,MULTILINE) var message = "Debug Reaction Has Been Played"

func _react():
	print(message)
	_complete_reaction()
	pass
