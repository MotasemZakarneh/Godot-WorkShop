extends HealthSystem
class_name Health

"""
Must be parented to a KinematicBody2D, RigidBody2D, or Area2D, or Static Body
"""

signal on_recieved_damage(damage,damage_sender,damage_type)
signal on_dead(damage_sender,damage_type)

export var max_health = 5
export var fill_on_start = true

export var is_dead = false
export var curr_health = 0

func _ready():
	if fill_on_start:
		curr_health = max_health
	pass

func recieve_damage(damage,damage_sender,damage_type):
	if is_dead:
		return
	
	var new_health = curr_health - damage
	if(new_health<=0):
		is_dead = true
		emit_signal("on_dead",damage_sender,damage_type)
	elif new_health>0:
		emit_signal("on_recieved_damage",damage,damage_sender,damage_type)
	curr_health = new_health
	pass

func _get_health_as_percent():
	return curr_health/max_health
