extends WeaponSystem
class_name Bullet

"""
dies on interaction, also dies once out of screen, other than that, same
as damager
"""

signal on_contact
export var hit_bodies = true
export (Array,String) var hit_groups = [  ]
export var damage = 1
export var damage_type = ""

var body : Area2D
var notifier : VisibilityNotifier2D
var damager : Damager

func _ready():
	if not get_parent() is Area2D:
		print("Bullet, must be a child of Area2D logged from " + name)
		queue_free()
		return
	
	body = get_parent()
	damager = Damager.new()
	damager.set_up(damage,body,damage_type)
	
	if has_node("VisibilityNotifier2D"):
		notifier = get_node("VisibilityNotifier2D")
		notifier.connect("screen_exited",self,"_on_out_of_screen")
	else:
		print("Add VisiblityNotifier as child of " + name + " for better performance")
	
	if hit_bodies:
		body.connect("body_entered",self,"_on_intersection")
	body.connect("area_entered",self,"_on_intersection")
	pass

func _on_intersection(intersection:Node):
	var no_group = intersection.get_groups().size() == 0 and hit_groups.size() == 0
	var groups_test = Extentions.test_groups_on_node(intersection,hit_groups)
	if no_group or groups_test:
		emit_signal("on_contact")
		damager.apply_damage(intersection)
		_kill()
	pass

func _kill():
	body.queue_free()
	pass

func _on_out_of_screen():
	_kill()
	pass
