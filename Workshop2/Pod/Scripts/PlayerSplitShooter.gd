extends Shooter

export var min_angle = -30
export var max_angle = 30
export var shots_count = 10

var shoot_point = null

func _i_ready():
	shoot_point = Extentions.get_child_of_name(body,["ShootPoint"])
	pass

func _build_bullets_pattern()->Array:
	var built_bullets = []
	
	var total_angle = abs (min_angle) + abs(max_angle)
	var angle_step = float(total_angle)/shots_count
	
	for i in range(shots_count):
		var rot = shoot_point.global_rotation_degrees + i*angle_step - total_angle/2.0
		rot = deg2rad(rot)
		var b =_create_bullet(bullet,shoot_point.global_position,rot)
		built_bullets.append(b)
		pass
	
	return built_bullets
