extends KinematicBody2D

var a = Color.red

func _ready():
	get_node("Sprite").modulate = a
	pass

func _on_Health_on_dead(damage_sender, damage_type):
	queue_free()
	pass
