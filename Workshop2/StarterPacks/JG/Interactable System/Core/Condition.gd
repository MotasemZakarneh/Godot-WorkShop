extends Object
class_name Condition

"""
Data holder helper class for conditions in the interactable system
"""
var description = "new condition"
var is_satisfied = false

func _init(descrip,new_satisfaction = false):
	self.description = descrip
	self.is_satisfied = new_satisfaction
	pass

func compare(test_description,test_is_satisfied)->bool:
	return self.descrip == test_description and self.is_satisfied == test_is_satisfied

func compare_c(c:Condition)->bool:
	return compare(c.description,c.is_satisfied)
