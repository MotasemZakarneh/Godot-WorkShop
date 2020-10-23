extends StaticBody2D

export (Color) var start_tint = Color.blueviolet
export (Color) var half_tint = Color.yellow
export (Color) var danger_tint = Color.red

export var half_point = 0.8
export var danger_point = 0.4

var health = null

func _ready():
	health = get_node("Health")
	modulate = start_tint
	pass

func _on_Health_on_recieved_damage(_damage, _damage_sender, _damage_type):
	var p = health.get_health_as_percent()
	if p<=half_point and p>danger_point:
		modulate = half_tint
	
	if p<=danger_point:
		modulate = danger_tint
	
	pass

func _on_Health_on_dead(_damage_sender, _damage_type):
	queue_free()
	pass

