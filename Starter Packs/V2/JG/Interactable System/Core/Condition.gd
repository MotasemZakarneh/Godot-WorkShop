extends Object
class_name Condition

"""
Data holder helper class for conditions in the interactable system
"""
var description = "new condition"
var is_satisfied = false

func _init(description,is_satisfied = false):
	self.description = description
	self.is_satisfied = is_satisfied
	pass

func compare(description,is_satisfied)->bool:
	return self.description == description and self.is_satisfied == is_satisfied

func compare_c(c:Condition)->bool:
	return compare(c.description,c.is_satisfied)
