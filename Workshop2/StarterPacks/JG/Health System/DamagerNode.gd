extends HealthSystem
class_name DamagerNode

"""
Must be parented to an Area2D
"""

signal on_damage_applied

enum DamageMode{Enter,Exit,External}
export (DamageMode) var damage_mode = DamageMode.Enter
export (Array,String) var hit_groups
export var damage = 1.0
export var damage_type = ""

var body : Area2D = null
var damager: Damager = null

func _ready():
	if not get_parent() is Area2D:
		print("Damager, must be a child of Area2D logged from " + name)
		queue_free()
		return
	
	body = get_parent()
	damager = Damager.new()
	damager.set_up(damage,body,damage_type)
	var _er
	match damage_mode:
		DamageMode.Enter:
			_er = body.connect("area_entered",self,"_on_intersection")
			_er = body.connect("body_entered",self,"_on_intersection")
		DamageMode.Exit:
			_er = body.connect("area_exited",self,"_on_intersection")
			_er = body.connect("body_exited",self,"_on_intersection")
	
	pass

func _on_intersection(intersection:Node):
	for g in hit_groups:
		if intersection.is_in_group(g):
			damager.apply_damage(intersection)
			emit_signal("on_damage_applied")
			return
	pass
