extends WeaponSystem
class_name Shooter

signal on_shot(bullet)

export (PackedScene) var bullet : PackedScene

export var shoot_map = "ui_accept"
export var continious_press = false

export var low_min_time_between_shots = 0.1
export var high_min_time_between_shots = 0.2

var cooling = false

func _ready():
	
	pass

func _process(_delta):
	if _shoot_input() and not cooling:
		_shoot()
	pass

func _shoot_input():
	if continious_press and Input.is_action_pressed(shoot_map):
		return true
	elif Input.is_action_just_released(shoot_map):
		return true
	return false

func _shoot():
	var bullet_node : Node2D = bullet.instance()
	get_tree().current_scene.add_child(bullet_node)
	bullet_node.global_position = global_position
	bullet_node.global_rotation = global_rotation
	cooling = true
	emit_signal("on_shot",bullet_node)
	yield(get_tree().create_timer(_min_time_between_shots()),"timeout")
	cooling = false
	pass

func _min_time_between_shots():
	return rand_range(low_min_time_between_shots,high_min_time_between_shots)
