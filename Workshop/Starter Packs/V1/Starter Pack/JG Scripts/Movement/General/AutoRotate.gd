extends MoveSystem
class_name AutoRotate

export var speed = 25

var body
func _ready():
	body = get_parent()
	pass

func _physics_process(delta):
	body.rotate(deg2rad(speed*delta))
	pass
