extends MoveSystem
class_name AutoMove

enum DirType{Right,Left,Up,Down}
export var speed = 700
export(DirType) var dir = DirType.Right
export var rotated = true

var body
var v_dir
var mover

func _ready():
	body = get_parent()
	mover = Mover.new()
	mover.set_up(body)
	pass

func _move_fixed_update(delta):
	v_dir = Vector2()
	match dir:
		DirType.Right:
			if rotated:
				v_dir = body.transform.x
			else:
				v_dir = Vector2.RIGHT
		DirType.Left:
			if rotated:
				v_dir = -body.transform.x
			else:
				v_dir = Vector2.LEFT
		DirType.Up:
			if rotated:
				v_dir = -body.transform.y
			else:
				v_dir = Vector2.UP
		DirType.Down:
			if rotated:
				v_dir = body.transform.y
			else:
				v_dir = Vector2.DOWN
	mover.move(v_dir*speed,delta)
	pass

func _on_is_locked():
	v_dir = Vector2.ZERO
	pass
