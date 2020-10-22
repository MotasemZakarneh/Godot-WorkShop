extends AI
class_name StateMachine

"""
Method 1: Inherit from this one, and use the functionality of transitioning directly.
Must Call run and pass self as the actor (or leave auto_run enabled)

Method 2: Add this as a child, let the parent control it, and call from the parent, and pass the parent.

Note: send_event_to_active_state this function is used to add interruptions to the AI FSM.
if the active state, can handle the event.
"""

export var auto_run = false

# Do not specifiy the type of the state, to avoid circular dependency
#as the state class, looks for the type of StateMachine.
var current_state = null
var last_state = null
var states = {}

func _ready():
	if auto_run:
		run(self)
	pass

func run(actor):
	if get_child_count()<=0:
		print("Trying To Run A State Machine, that has no states")
	
	for c in get_children():
		var state_name : String = c.name
		states[c.name] = c
		states[state_name.to_lower()] = c
		states[state_name.to_upper()] = c
		c.init(actor,self)
	
	transition_to_state_n(get_child(0).name)
	pass

func _process(delta):
	if current_state != null:
		current_state.on_process(delta)
	pass

func _physics_process(delta):
	if current_state != null:
		current_state.on_physics_process(delta)
	pass

func transition_to_state_n(new_state_n:String):
	if not states.has(new_state_n):
		print(name + " Can't Transition to state " + new_state_n + " its not found in dictionary")
		return
	var new_state = states[new_state_n]
	if current_state != null:
		current_state.on_exit()
		last_state = current_state.name
	current_state = new_state
	current_state.on_enter()
	pass

func send_event_to_active_state(e : String):
	if current_state != null:
		current_state.recieve_event(e)
	pass
