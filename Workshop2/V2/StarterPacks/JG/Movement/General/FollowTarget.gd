extends MoveSystem
class_name FollowTarget

export var target_group = "Follow Target"
export var speed = 300
export var face_target = false

var target
var body:Node2D
var mover
var dir:Vector2

func _ready():
	target = get_tree().get_nodes_in_group(target_group)[0]
	body = get_parent()
	mover = Mover.new()
	mover.set_up(body)
	pass

func _move_fixed_update(delta):
	if not is_instance_valid(target):
		return
	dir = (target.global_position - body.global_position).normalized()
	mover.move(dir*speed,delta)
	if not face_target:
		return
	body.global_rotation = dir.angle()
	pass
