extends Object
class_name Damager

var damage
var body
var damage_type

func set_up(dam,bod,dam_type):
	self.damage = dam
	self.body = bod
	self.damage_type = dam_type
	pass

func apply_damage(target):
	var h = target
	if h is Health:
		h.recieve_damage(damage,body,damage_type)
		return
	h = Extentions.get_child_of_type(target,[Health])
	if h == null:
		return
	h.recieve_damage(damage,body,damage_type)
	pass
