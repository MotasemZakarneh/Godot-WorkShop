extends MoveSystem
class_name FaceMouse

var body : Node2D

func _ready():
	body = get_parent()
	pass

func _move_fixed_update(_delta):
	var disp = body.global_position - body.get_global_mouse_position()
	var dir = disp.normalized()
	body.rotation = dir.angle()
	pass
