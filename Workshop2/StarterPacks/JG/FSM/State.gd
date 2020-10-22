extends AI
class_name State

"""
Create a base State for each unit, usually where it casts the actor to the type of itself 
func my_self -> the_cool_unit_type():
	return actor as the_cool_unit_type

then, create Children of that new base state, and override the overridable functions
"""

var actor : Node = null
var machine : StateMachine = null

func init(actor : Node , machine : StateMachine):
	self.actor = actor
	self.machine = machine
	pass

#override these to get behavior inside of your state
func on_enter():
	
	pass

func on_process(delta):
	
	pass

func on_physics_process(delta):
	
	pass

func on_exit():
	
	pass

#use thise to add interruptions, event is recieved from StateMachine externally.
#use this for specific changes of the world, such as, being hit, or hitting a block.
func recieve_event(e: String):
	
	pass
