extends WeaponSystem
class_name Shooter

signal on_shot(bullets_pattern)

export (PackedScene) var bullet : PackedScene

export var shoot_map = "ui_accept"
export var continious_press = false

export var low_min_time_between_shots = 0.1
export var high_min_time_between_shots = 0.2

var cooling = false
var sprite = null
var body = null

func _ready():
	body = get_parent()
	sprite = Extentions.get_visual_body(body)
	_i_ready()
	pass

func _process(_delta):
	if _shoot_input() and not cooling:
		_shoot()
	
	_i_process(_delta)
	pass

func _shoot_input():
	if continious_press and Input.is_action_pressed(shoot_map):
		return true
	elif Input.is_action_just_released(shoot_map):
		return true
	return false

func _shoot():
	var bullets_pattern = _build_bullets_pattern()
	cooling = true
	emit_signal("on_shot",bullets_pattern)
	yield(get_tree().create_timer(_min_time_between_shots()),"timeout")
	cooling = false
	pass

func _create_bullet(bullet_scene,spawn_pos,spawn_rot):
	if bullet_scene == null:
		print ("Trying to create a bullet with no scene at " + get_path())
		return null
	
	var bullet_node : Node2D = bullet_scene.instance()
	get_tree().current_scene.add_child(bullet_node)
	bullet_node.global_position = spawn_pos
	bullet_node.global_rotation = spawn_rot
	return bullet_node

func _min_time_between_shots():
	return rand_range(low_min_time_between_shots,high_min_time_between_shots)

#override this to change the shooting behavior
#use the _create_bullet function to handle creating new bullets
func _build_bullets_pattern()->Array:
	var b1 = _create_bullet(bullet,sprite.global_position,sprite.global_rotation)
	var bullets = [b1]
	return bullets

#an update/ready function to use in extended classes
func _i_process(_delta):
	
	pass

func _i_ready():
	
	pass
