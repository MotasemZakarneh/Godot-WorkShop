extends Object
class_name Mover

var body

func _init():
	pass

func set_up(body_to_move):
	self.body = body_to_move
	pass

func move(vel,delta):
	if body is KinematicBody2D:
		return body.move_and_slide(vel)
	elif body is Area2D or body is Node2D:
		body.translate(vel*delta)
	return vel
