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
export var min_time_between_hits = 0.1

var can_take_damage = true
var damage_cd_counter = 0

func _ready():
	if fill_on_start:
		curr_health = max_health
	pass

func _process(delta):
	if can_take_damage:
		return
	
	damage_cd_counter = damage_cd_counter + delta/min_time_between_hits
	
	if damage_cd_counter>1:
		can_take_damage = true
		damage_cd_counter = 0
	
	pass

func recieve_damage(damage,damage_sender,damage_type):
	if not can_take_damage:
		return
	
	if is_dead:
		return
	
	var new_health = curr_health - damage
	if(new_health<=0):
		is_dead = true
		emit_signal("on_dead",damage_sender,damage_type)
	elif new_health>0:
		emit_signal("on_recieved_damage",damage,damage_sender,damage_type)
	curr_health = new_health
	
	if min_time_between_hits<=0:
		return
	
	can_take_damage = false
	pass

func get_health_as_percent():
	return float(curr_health)/float(max_health)
